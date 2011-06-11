module CoffeeTrace
  class InsertLogging
    
    def initialize insert_log_statement=CoffeeTrace::InsertLogStatement.new
      @insert_log_statement = insert_log_statement
    end
    
    def into lines, prefix=nil
      result = []
      lines.each do |line|
        result.pop if is_coffee_trace_log?(line)  
	result << line
	result << (@insert_log_statement.for line, prefix)
      end
      result.compact
    end 

    def is_coffee_trace_log? line
      return true if /#coffee_trace$/.match line
    end
  end	
end
