def super_print(str, options = {})
  defaults = {
    times: 1,
    upcase: false,
    reverse: false
  }
  
  options = defaults.merge(options)
  new_str = str * options[:times]
  new_str.upcase! if options[:upcase]
  new_str.reverse! if options[:reverse]
  new_str
end