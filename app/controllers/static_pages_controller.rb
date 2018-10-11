class StaticPagesController < ApplicationController
  before_action :authenticate_user!

  def home
  end

  def store_log
    upfile = params[:localfile]
    uploader = InspectLogUploader.new

    # 首先将上传的文档放在cache中
    uploader.cache!(upfile)

    # 然后填表，当填完表分析过后，再将文件放到存储目录下分类保存

    respond_to do |f|
      f.js
      f.html
    end
a end

end
