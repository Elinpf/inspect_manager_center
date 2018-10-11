class FileName
  class << self
    def with_date(file, year=nil, month=nil, day=nil)
      if year.nil?
        time  = Time.now
        year  = time.year
        month = time.month
        day   = time.day
        sec   = time.to_i
      end

      # 将文件名中的后缀分离
      ext = File.extname(file)
      basename = File.basename(file, ext)
      dir = File.dirname(file)

      # 将文件加入日期
      new_name = [basename, year, month, day, sec].join('-')
      real_path(File.join(dir, (new_name + ext)))
    end

    # 将后缀名改为xml
    def to_xml(file)
      ext = File.extname(file)
      basename = File.basename(file, ext)
      dir = File.dirname(file)

      real_path(File.join(dir, (basename + '.xml')))
    end

    # 默认是不会显示public路径的
    def real_path(file)
      Rails.root.join('public', file)
    end
  end
end
