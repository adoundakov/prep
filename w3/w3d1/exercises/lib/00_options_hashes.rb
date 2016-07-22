def transmogrify(input_string, options = {})
  defaults = {
    times: 1,
    reverse: false,
    downcase: false,
    upcase: false
  }

  modifiers = defaults.merge(options)
  modified_string = input_string

  modifiers.each do |action, option|
    if option == true
      modified_string = modified_string.send(action)
    end
  end
  out_string = ''
  modifiers[:times].times {out_string << modified_string}

  out_string
end
