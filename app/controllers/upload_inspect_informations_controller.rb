class UploadInspectInformationsController < ApplicationController

  def upload
    @store_file = StoreFile.new
    console
  end

  def store_and_analysis
    @store_file = StoreFile.new(upload_params)

    # 由于没有User，必然会导致失败，而有一个就说明其实是成功的
    @store_file.valid?
    unless @store_file.errors.size == 1
      return render 'upload'
    end
    time = Time.now

    @store_file.user = current_user

    # 将上传的文件放入临时文件夹
    loader = InspectLogUploader.new

    # 传入需要保存的路径信息
    loader.path_info = set_path_info
    loader.cache!(upload_params[:path])

    # 生成输出文件的文件名
    output_file_org = FileName.to_xml(loader.cache_path)
    output_file     = FileName.with_date(output_file_org, time)

    # 开始用aio分析上传的文件
    real_cache_path = FileName.real_path(loader.cache_path)
    aio_device_manager = aio_parser_console_to_xml(real_cache_path, output_file)

    # 分析完成后，将文件放入正式目录中
    loader.store!

    # 将生产的文件也放到那个目录下
    real_store_path_xml = FileName.to_xml(
      FileName.real_path(loader.store_path))
    FileUtils.mv(output_file, real_store_path_xml)

    # 保存到数据库
    # 版本按照时间来确定
    @store_file.version = time.to_i
    @store_file.inspect_time = inspect_time.join('-')
    @store_file.client = upload_params[:client]
    @store_file.locate = upload_params[:locate]
    @store_file.path = FileName.real_path(loader.store_path)
    @store_file.parser_path = real_store_path_xml
    
    @store_file.save
  end

  private

  # 设置保存路径的信息
  def set_path_info
    path_info = {}
    path_info[:client] = upload_params[:client]
    path_info[:locate] = upload_params[:locate]
    path_info[:inspect_time] = inspect_time.join('-')

    # 还可以在路径中加入工程师的名字
    # 防止有多个版本，加入时间区分
    path_info[:sec] = Time.now.to_i
    path_info
  end

  # 提取巡检时间，以数组格式返回
  def inspect_time
    date = []
    date << upload_params["inspect_time(1i)"]
    date << upload_params["inspect_time(2i)"]
    date << upload_params["inspect_time(3i)"]
    date
  end

  def upload_params
    params.require(:store_file).permit(:client, :inspect_time, :path, :locate)
  end
end
