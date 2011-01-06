require 'rubygems'
require 'treetop'

Treetop.load 'polish'

class PolishParser
  def calculate(string)
    res = parse(string)
    if !res
      raise "Parsing error at line #{failure_line} char: #{failure_column} #{failure_reason}"
    else
      res.eval
    end
  end
end
