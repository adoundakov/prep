class Friend
  def greeting(who = nil)
    return "Hello!" if who.nil?
    "Hello, #{who}!"
  end
end
