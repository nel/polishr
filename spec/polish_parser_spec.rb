require File.dirname(__FILE__) + '/../polish_parser'

describe Polish do
  it "Should support addition" do
    PolishParser.new.calculate("+ 1 2").should == 3
  end
  
  it "Should support recusive addition" do
    PolishParser.new.calculate("+ + 1 2 3").should == 6
    PolishParser.new.calculate("+ 1 + 2 3").should == 6
  end

  it "Should support multiple operator" do
    PolishParser.new.calculate("+ 1 * 4 5").should == 21
  end
end
