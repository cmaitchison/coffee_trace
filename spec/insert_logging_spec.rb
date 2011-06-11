require 'coffee_trace'

describe CoffeeTrace::InsertLogging do
 
  before do
    @insert_log_statement = "insert_log_statement"
    @insert_logging = CoffeeTrace::InsertLogging.new @insert_log_statement
    @insert_log_statement.should_receive(:for).with("line1", "prefix").and_return(nil)
    @insert_log_statement.should_receive(:for).with("line2", "prefix").and_return("prefix-log1")
    @insert_log_statement.should_receive(:for).with("line3", "prefix").and_return(nil)
    @insert_log_statement.should_receive(:for).with("line4", "prefix").and_return("prefix-log2")
  end

  it "inserts a logging line after each function" do
    lines = ["line1", "line2", "line3","line4"]

    result = @insert_logging.into lines, "prefix"
    result.should == 
      ["line1","line2","prefix-log1","line3","line4","prefix-log2"]
  end

  it "does not add a log statement for a method if it already has a coffee_trace log statement" do
    lines = ["line1", "line2", "line3","line4","console.log #coffee_trace"]
    @insert_log_statement.should_receive(:for).with("console.log #coffee_trace", "prefix").and_return(nil)
    result = @insert_logging.into lines, "prefix"
    result.should == 
      ["line1","line2","prefix-log1","line3","line4","console.log #coffee_trace"]
  end
  
end
