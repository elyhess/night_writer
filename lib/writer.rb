require_relative './alphabet'

class Writer
  attr_reader :imported_text, :output, :alpha
  
  def initialize(input, output)
    @imported_text = input 
    @output = output
    @alpha = Alphabet.key
  end

  def export
    File.write(output, english_to_braille)
    puts "Created '#{output}' containing #{imported_text.chars.length} characters."
  end

end