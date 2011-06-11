module CoffeeTrace
  class CLI

    def initialize insert_logging=CoffeeTrace::InsertLogging.new
      @insert_logging = insert_logging
      @files = Dir.glob "**/*.coffee"
    end

    def insert_logging
      @files.each do |file|
	prefix =File.basename file, ".coffee"
	result = @insert_logging.into File.readlines(file), prefix
	write_lines file, result 
      end
    end

    def remove_logging
      @files.each do |file|
	lines = @insert_logging.into File.readlines(file)
        result = lines.select do |line|
	  /console\.log.*#coffee_trace.*/.match(line).nil?
	end
	write_lines file, result
      end
    end

    def write_lines(path, data)
      File.open(path, "wb") do |file|
        file.puts data
      end
    end
  
  end
end
