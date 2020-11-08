require_relative './alphabet'

class Writer
  attr_reader :imported_text, :output, :alpha
  
  def initialize(input, output)
    @imported_text = input 
    @output = output
    @alpha = Alphabet.key
  end

end