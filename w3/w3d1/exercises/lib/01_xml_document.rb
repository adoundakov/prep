class XmlDocument
  attr_reader :ind_level, :indent

  def initialize(indent = false)
    @indent = indent
    @ind_level = 0
  end

  def method_missing(method_name, *args, &blk)
    document = ''
    attrs = args[0] || {} # since the args passed in are hashes
    document << ('  ' * ind_level) if indent
    document << "<#{method_name}"

    attrs.each_pair do |k, v|
      document << " #{k}=\"#{v}\""
    end

    if blk
      document << '>'
      document << "\n" if indent
      @ind_level += 1
      document << yield
      @ind_level -= 1
      document << ("  " * ind_level) if indent
      document << "</#{method_name}>"
      document << "\n" if indent
    else
      document << "/>"
      document << "\n" if indent
    end

    document
  end
end
