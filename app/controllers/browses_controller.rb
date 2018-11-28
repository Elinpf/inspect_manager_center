class BrowsesController < ApplicationController

  # you can disable csrf protection on controller-by-controller basis:  
  protect_from_forgery except: :index 
  skip_before_action :verify_authenticity_token  

  def show
    return redirect_to browses_path if params[:id] == 'compare'
    @sf = StoreFile.find(params[:id])
    
    @device_manager = aio_parse_console(@sf.path)
  end

  def index
    @store_files = StoreFile.paginate(page: params[:page])
    @cl_group = StoreFile.client_and_location_group
  end

  def history
    @sf = StoreFile.find(params[:id])

    @history_arr = @sf.history
  end

  def compare
    compare_one = params['key1'].split('client-')[1]
    compare_two = params['key2'].split('client-')[1]
    return if compare_one.nil? or compare_two.nil?

    sf_one = StoreFile.find_by_id(compare_one)
    sf_two = StoreFile.find_by_id(compare_two)

    @device_manager = aio_parse_compare(sf_one.path, sf_two.path)
  end

  def download_excel
    @sf = StoreFile.find(params[:id])

    # 生成excel临时文件
    tmp_file = aio_parse_to_wps_excel(@sf.path, random_temp_path)
    return if tmp_file.nil?
    send_file(tmp_file, filename: "#{@sf.slug + '.xls'}")
  end

  def download_summary
    @sf = StoreFile.find(params[:id])

    # 生成summary临时文件
    tmp_file = aio_parse_to_summary(@sf.path, random_temp_path)
    return if tmp_file.nil?
    send_file(tmp_file, filename: "#{@sf.slug + '.doc'}")
  end
end
