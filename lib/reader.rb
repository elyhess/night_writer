require_relative './alphabet'
class Reader
  attr_reader :imported_braille, :output, :alpha
  
  def initialize(input, output)
    @imported_braille = input 
    @output = output
    @alpha = Alphabet.key.invert
  end

end 