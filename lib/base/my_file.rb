class MyFile < File
  include File::Tail

  def self.last_line(filename)
    result = ''
    open(filename) do |file|
      file.backward(1)
      result = file.tail(1).first
    end

    return result
  end
end
