module CoffeeTrace  
  class InsertLogStatement
    def for line, prefix=nil
      leading_spaces, method_name, args = parse_function line
      return unless leading_spaces
      method_name = (prefix + "-" + method_name) if prefix 
      result = "#{leading_spaces}  console.log '#{method_name}'"
      result += ", #{args}" if args 
      result += " #coffee_trace"
      result 
    end

    private
    def parse_function line
      no_arg_function_match = line.scan(/^( *)(\w+): * \(? *\)? *[-=]> *$/)
      no_arg_function_match.empty? ? parse_function_with_args(line) : no_arg_function_match.first
    end

    def parse_function_with_args line
      arg_function_match = line.scan(/^( *)(\w+): *\((.*)\) *[-=]> *$/)
      arg_function_match.empty? ? nil : arg_function_match.first
    end
  end

end
