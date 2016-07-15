class RPNCalculator

  def initialize
    @store = []
  end

  def value
      @store.last
  end

  def push(number)
    @store << number
  end

  def plus
    unless empty?
      b,a = pop , pop
      @store << a + b
    end
  end

  def minus
    unless empty?
      b,a = pop , pop
      @store << a - b
    end
  end

  def times
    unless empty?
      b,a = pop , pop
      @store << a * b
    end
  end

  def divide
    unless empty?
      b,a = pop , pop
      @store << a.fdiv(b)
    end
  end

  def tokens(string)
    operations = ['+', '-', '*', '/']
    tokens = string.split
    rpn_input = []
    tokens.each do |token|
      if operations.include?(token)
        rpn_input << token.to_sym
      else
        rpn_input << token.to_i
      end
    end

    rpn_input
  end

  def evaluate(string)
    symbols = {:+ => :plus, :- => :minus, :* => :times, :/ => :divide}

    rpn_input = tokens(string)

    rpn_input.each do |token|
      if token.class == Symbol
        send(symbols[token])
      else
        push(token)
      end
    end

    value
  end

  def empty?
    if @store.empty?
      raise Exception.new("calculator is empty")
    end
  end

  def pop
      @store.pop
  end
end
