class Printer
  TAGS = { eql: ' ',
           ins: '<p>+</p>',
           del: '<p>-</p>' 
  }

  LINE_WIDTH = 4

  # [A, B]
  # A = 有删除的部分
  # B = 有增加的部分
  def printer(diff)

    @print = []
    @change_block = ChangeBlock.new
    get_change_line(diff)
  end

  def get_change_line(diff)

    diff.each do |edit|
      print_edit(edit)
    end

    # 将最后一行没有加上的补齐
    if @change_block.has_block?
      @print.concat(@change_block.end_block)
    end

    @print
  end


  def print_edit(edit)
    case edit.type
    when :eql
      if @change_block.has_block?
        tmp = @change_block.end_block
        @print.concat(tmp)
      end
      @print << [edit, edit]

    else
      @change_block << edit
    end
  end
end

class ChangeBlock
  def initialize
    @block = []
  end

  def end_block
    tmp = neat
    @block.clear
    return tmp
  end

  # 将block中的内容整理成所需要的格式
  def neat
    res = { ins: [], del: [] }
    @block.each do |e|
      if e.type == :ins
        res[:ins] << e
      elsif e.type == :del
        res[:del] << e
      end
    end

    ins_size = res[:ins].size
    del_size = res[:del].size

      
    # 为行数不同的填充空行
    if ins_size > del_size
      less = ins_size - del_size
      res[:del] += Array.new(less) { Aio::Base::Toolkit::Diff::Edit.empty_line }

    elsif ins_size < del_size
      less = del_size - ins_size
      res[:ins] += Array.new(less) { Aio::Base::Toolkit::Diff::Edit.empty_line }
    end

    tmp = []
    res[:ins].size.times do |n|
      tmp[n] = [ res[:del][n], res[:ins][n] ]
    end

    return tmp
  end


  def <<(diff)
    @block << diff
  end

  def block
    @block
  end

  def has_block?
    !@block.empty?
  end
end
