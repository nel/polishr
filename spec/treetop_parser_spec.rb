top = File.join(File.dirname(__FILE__),'..')
require "#{top}/treetop_polish_parser"
require "#{top}/spec/polish_parser_example"

describe "Treetop Polish Parser" do
    before do
      @parser = TreetopPolishParser
    end

    it_should_behave_like "polish parser"
end
