top = File.join(File.dirname(__FILE__),'..')
require "#{top}/handcraft_polish_parser"
require "#{top}/spec/polish_parser_example"

describe "Handcraft Polish Parser" do
    before do
        @parser = HandcraftPolishParser
    end

    it_should_behave_like "polish parser"
end
