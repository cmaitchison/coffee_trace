require 'coffee_trace'

describe CoffeeTrace::InsertLogStatement do
  
  before do
    @insert_log_statement = CoffeeTrace::InsertLogStatement.new
  end

  it "returns nil if line is not a function" do
    assert "some code", nil
    assert "  more code", nil 
  end

  it "returns a log statement for a function with no arguments" do
    assert "  initialize: ->", "    console.log 'initialize' #coffee_trace"
    assert "    render: ->", "      console.log 'render' #coffee_trace"
  end

  it "returns a log statement for a function with arguments" do
    assert "  doStuff: (arg1, arg2, arg3) ->", "    console.log 'doStuff', arg1, arg2, arg3 #coffee_trace"
  end

  it "returns a correct log statement for a function with an empty arguments list" do
    assert "  doStuff: () ->", "    console.log 'doStuff' #coffee_trace"
  end

  it "returns a log statement for a fat arrow function" do
    assert "  doStuff: (arg1, arg2, arg3) =>", "    console.log 'doStuff', arg1, arg2, arg3 #coffee_trace"
    assert "  initialize: =>", "    console.log 'initialize' #coffee_trace"
    assert "  placeSelectedHandler: (e, placeId) =>", "    console.log 'placeSelectedHandler', e, placeId #coffee_trace"
    assert "  renderPoi: (poi) =>", "    console.log 'renderPoi', poi #coffee_trace"
  end

  it "handles trailing spaces" do
    assert "  initialize: -> ", "    console.log 'initialize' #coffee_trace"
  end

  it "adds a prefix if given" do
    assert_with_prefix "  initialize: -> ","trace_logger","    console.log 'trace_logger-initialize' #coffee_trace"
  end
  
  it "indents correctly" do
    assert "a: ->", "  console.log 'a' #coffee_trace"
    assert "  a: ->", "    console.log 'a' #coffee_trace"
    assert "    a: ->", "      console.log 'a' #coffee_trace"
    assert "      a: ->", "        console.log 'a' #coffee_trace"
  end
  
  def assert line, expected_value
    @insert_log_statement.for(line).should == expected_value
  end
  
  def assert_with_prefix line, prefix, expected_value
    @insert_log_statement.for(line, prefix).should == expected_value
  end
end
