def add(a , b)
  a + b
end

def subtract(a, b)
  a - b
end

def sum(nums)
  sum = 0
  nums.each do |num|
    sum += num
  end

  sum
end

def multiply(a, b)
  a * b
end

def power(a, pow)
  a ** pow
end

def factorial(num)
  if num == 1 or num == 0
    return 1
  else
    return num * factorial(num - 1)
  end
end
