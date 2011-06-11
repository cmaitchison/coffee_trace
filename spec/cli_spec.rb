require 'coffee_trace'

describe CoffeeTrace::CLI do

  before do
    @insert_logging = CoffeeTrace::InsertLogging.new
    Dir.should_receive(:glob).with("**/*.coffee").and_return(["a.coffee","b.coffee"])
    @cli = CoffeeTrace::CLI.new @insert_logging
  end

  it "inserts logging into each file" do
    file1 = ["a","b"]
    file2 = ["c","d"]
    File.should_receive(:readlines).with("a.coffee").and_return(file1)
    File.should_receive(:readlines).with("b.coffee").and_return(file2)
    @insert_logging.should_receive(:into).with(file1,"a").and_return(["z","y"])
    @insert_logging.should_receive(:into).with(file2,"b").and_return(["w","x"])
    @cli.should_receive(:write_lines).with("a.coffee",["z","y"])
    @cli.should_receive(:write_lines).with("b.coffee",["w","x"])
    @cli.insert_logging
  end

  it "removes logging from each file" do
    file1 = ["a","b","console.log blah #coffee_trace"]
    file2 = ["c","console.log blahblah #coffee_trace", "d"]
    File.should_receive(:readlines).with("a.coffee").and_return(file1)
    File.should_receive(:readlines).with("b.coffee").and_return(file2)
    @cli.should_receive(:write_lines).with("a.coffee",["a","b"])
    @cli.should_receive(:write_lines).with("b.coffee",["c","d"])
    @cli.remove_logging
  end
end
