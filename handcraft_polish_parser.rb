if RUBY_VERSION < '1.9'
    raise 'Ruby < 1.9 is not supported as this parser implementation relies on hash beeing sorted which is not the case before 1.9'
end

class Token
  attr_accessor :value
  attr_accessor :type

  def initialize
  end

  def method_missing(method, *args)
    if method.to_s =~ /^(\w+)\?$/ && Lexer::LEXEMES.keys.include?($1.to_sym)
      self.type == $1.to_sym
    else
      super
    end
  end

  def unknown?
    self.type.nil?
  end
end

class Lexer
  LEXEMES = {
    :float => /\A\-?[0-9]+\.[0-9]+/,
    :integer => /\A\-?[0-9]+/,
    :operator => /\A[\+\-\/\*]/,
    :end => /^$/,
    :lparen => /\A\(/,
    :rparen => /\A\)/
  }
  
  def initialize(input)
    @input = input
  end

  def next_token
    t = Token.new
    @input.lstrip! #space separated

    LEXEMES.each do |(type, regexp)|
        if @input =~ regexp
          t.type = type
          t.value = $&
          break
        end
    end
    
    raise ArgumentError.new("Token unknown at #{@input}") if t.unknown?
    @input = $'
    return t
  end
end

class HandcraftPolishParser
  def initialize
  end

  def parse(string)
    @lexer = Lexer.new(string)

    result = expression

    token = @lexer.next_token
    if token.end?
      return result
    else
      raise ArgumentError.new("Bad ending in input")
    end
  end

  def expression
    token = @lexer.next_token
    
    if token.integer?
      return token.value.to_i
    elsif token.float?
      return token.value.to_f
    elsif token.operator?
      return operation(token)
    elsif token.lparen?
      value = expression
      raise ArgumentError.new("Parenthesis is not properly closed") unless @lexer.next_token.rparen?
      return value 
    else
      raise ArgumentError.new("Incorrect expression")
    end
  end

  def operation(operator)
    arg1 = expression
    arg2 = expression

    return arg1.send operator.value, arg2 #execute operation
  end

  def calculate(string)
    parse(string)
  rescue ArgumentError => e
    puts "Failed to parse: #{e.message}"
  end
end
