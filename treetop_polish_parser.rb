require 'treetop'

Treetop.load File.dirname(__FILE__) + '/polish'

class TreetopPolishParser < PolishParser
  def calculate(string)
    res = parse(string)
    if !res
      raise "Parsing error at line #{failure_line} char: #{failure_column} #{failure_reason}"
    else
      res.eval
    end
  end
end
