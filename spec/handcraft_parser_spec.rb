top = File.join(File.dirname(__FILE__),'..')
require "#{top}/handcraft_polish_parser"
require "#{top}/spec/spec_helper"

describe "Handcraft Polish Parser" do
    before do
        @parser = HandcraftPolishParser
    end

    it_should_behave_like "polish parser"
end
