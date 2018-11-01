class MyZip
  DefaultTempDir = Rails.root.join('public', 'zip')

  attr_accessor :unzipped_file

  def initialize(file)
    @temp_dir = DefaultTempDir.join(Rand.base64)
    @file = file
  end

  # 解压缩
  def unzip
    # 如果不是压缩文件，那么就直接返回文件就可以了
    return self unless zip?
    @unzip = ZipDir::Unzipper.new(@file)
    @unzipped_path = @unzip.unzip_path
    self
  end

  # 如果没有解压，那么就把原本的地址作为解压地址
  def unzipped_path
    @unzipped_path ||= @file
  end

  # 判断是否为解压文件
  def zip?
    '.zip' == File.extname(@file)
  end

  # 判断是否解压过
  def unzipped?
    @unzip.nil? ? false : @unzip.unzipped?
  end

  def clearup
    @unzip.clearup unless @unzip.nil?
  end

end
