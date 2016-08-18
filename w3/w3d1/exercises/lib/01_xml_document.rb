class XmlDocument
  attr_reader :tag

  def initialize(indent = false)
    @tag = ''
  end

  def method_missing(method_name, arg = nil)
    if block_given?
      # stuff
    end
  end
end
