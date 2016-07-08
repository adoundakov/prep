class RPNCalculator
  attr_reader :store

  def initialize
    @store = []
  end

  def value
    store.last unless empty?
  end

  def push(number)
    @store << number
  end

  def plus
    unless empty?
      store << pop + pop
    end
  end

  def minus
    unless empty?
      store << pop - pop
    end
  end

  def times
    unless empty?
      store << pop * pop
    end
  end

  def divide
    unless empty?
      store << pop / pop
    end
  end

  def tokens(string)
  end

  def evaluate(string)
  end

  private

  @operations = {'+' => :plus, '-' => :minus,
                '*' => :times, '/' => :divide}

  def empty?
    if @store.empty?
      raise Exception.new("calculator is empty")
    end
  end

  def pop
    if operations[value]
      self.operations[value] # need to fix this function call
    else
      @store.pop
    end
  end
end
