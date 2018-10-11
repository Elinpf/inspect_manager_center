module AioHelper
  # FIXME 修改此处require
  require '/root/lib/aio/lib/aio'

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
    @aio_input_klass.input_file = input_file
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

  def aio_parse(input_file, output_file)
    aio_input_parse(input_file)
    aio_output_parse(output_file) # FIXME 修改成temp下随机名称文件
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

  def aio_parser_console_to_xml(input_file, output_file)
    aio_init
    aio_input_module('input/style/console')
    aio_output_module('output/style/compare_xml')
    aio_parse(input_file, output_file)
  end
end
