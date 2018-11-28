module AioHelper
  # FIXME 修改此处require
  require '/root/lib/aio/lib/aio'

  DefaultInputCompareXML          = 'input/style/compare_xml'
  DefualtInputConsole             = 'input/style/console'
  DefaultOutputCompareXML         = 'output/style/compare_xml'
  DefaultOutputWPSExcel           = 'output/style/excel_table_wps'
  DefaultOutputSummary            = 'output/style/summary_report'
  DefaultCompare                  = "special/style/compare"
  DefaultCompareWithDeviceManager = "special/style/compare_with_device_manager"


  def aio_init
    @module_manager = Aio::ModuleManager.new
    module_loader = Aio::Module::Loader.new(@module_manager)
    module_loader.load_modules(module_loader.modules_path)

    @device_manager = Aio::DeviceManager.new(@module_manager)
    parser_machine = Aio::Parse::ParserMachine.new(@device_manager)
    @parser = Aio::Parse::Parser.new(@device_manager, parser_machine)

    # 每次清空日志
    Aio::Ui::Logger.instance.clear_log
  end

  def aio_input_module(mod_name)
    @aio_input_klass = @module_manager.get_module_klass_by_name(mod_name)
  end

  def aio_output_module(mod_name)
    @aio_output_klass = @module_manager.get_module_klass_by_name(mod_name)
  end

  def aio_input_parse(input_file)
    # 判断是否为压缩文件，并返回文件
    unzip = MyZip.new(input_file).unzip

    @aio_input_klass.input_file = unzip.unzipped_path
    @parser.input_klass = @aio_input_klass
    @aio_input_klass.ext_info = {cmds_reg: @device_manager.just_cmds_reg}

    @parser.parse_by_module
    @parser
  end

  def aio_output_parse(output_file)
    @aio_output_klass.output_file = output_file
    @aio_output_klass.device_manager = @device_manager
    @aio_output_klass.generate
    
    # 返回最终的生成文件名
    return @aio_output_klass.output_file
  end

  def aio_parse(input_file, output_file=nil)
    aio_input_parse(input_file)
    aio_output_parse(output_file) unless output_file.nil?
    @device_manager
  end

  # 返回是否为windows服务器
  def windows?
    Aio::Base::Toolkit::OS.windows?
  end

  def os_family
    Aio::Base::Toolkit::OS.os_family
  end

  # 判断output模块是否在本服务器上可用
  def active?(info)
    os = os_family
    if info[:klass].platform.include?(os)
      return true
    else
      return false
    end
  end

  # 返回数组info日志
  def logger_info
    Aio::Ui::Logger.instance.info
  end

  def aio_parse_console_to_xml(input_file, output_file)
    aio_init
    aio_input_module(DefualtInputConsole)
    aio_output_module(DefaultOutputCompareXML)
    aio_parse(input_file, output_file)
  end

  #  检验生成的xml是否完整
  def check_xml(file)
    line = MyFile.last_line(file)
    line[0] == ' '
  end

  # 解析xml文件，返回device_manager
  # 暂时还不能用，需要修改aio文件的parser.rb
  def aio_parse_xml(xml_f, real_f)
    return unless check_xml(xml_f)
    
    aio_init
    aio_input_module(DefaultInputCompareXML)
    aio_parse(xml_f)
  end

  # 分析console类型的文件，返回device_manager
  def aio_parse_console(file)
    aio_init
    aio_input_module(DefualtInputConsole)
    aio_parse(file)
  end

  def aio_parse_compare(file_one, file_two)
    other_device_manager = aio_parse_console(file_one)
    aio_parse_console(file_two)

    compare_klass = @module_manager.get_module_klass_by_name(DefaultCompareWithDeviceManager)

    @parser.parse_by_compare_with_device_manager(compare_klass, other_device_manager)
    @device_manager
  end

  def aio_myers(diff)
    Aio::Base::Toolkit::Diff.diff(diff)
  end

  # 返回一个字符串数组
  def aio_print(diff)
    Printer.new.printer(aio_myers(diff))
  end

    
  def aio_parse_to_wps_excel(input_file, output_file)
    return unless windows?
    aio_init
    aio_input_module(DefaultInputConsole)
    aio_output_module(DefaultOutputWPSExcel)
    aio_input_parse(input_file)
    aio_output_parse(output_file)
  end
    
  def aio_parse_to_summary(input_file, output_file)
    return unless windows?
    aio_init
    aio_input_module(DefaultInputConsole)
    aio_output_module(DefaultOutputSummary)
    aio_input_parse(input_file)
    aio_output_parse(output_file)
  end

  def aio_parse_to_wps_excel_test(input_file, output_file)
    aio_init
    aio_input_module(DefualtInputConsole)
    aio_output_module(DefaultOutputCompareXML)
    aio_input_parse(input_file)
    aio_output_parse(output_file)
  end

  # 随机生成文件名称
  def random_temp_path
    Rails.root.join('tmp', SecureRandom.alphanumeric)
  end
end
