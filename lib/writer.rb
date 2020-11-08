require_relative './alphabet'

class Writer
  attr_reader :imported_text, :output, :alpha
  
  def initialize(input, output)
    @imported_text = input 
    @output = output
    @alpha = Alphabet.key
  end

  def export
    File.write(output, imported_text)
    puts "Created '#{output}' containing #{imported_text.chars.length} characters."
  end

  def too_long?(imported_text)
    imported_text.length > 40 
  end

  def convert_to_braille(line)
    braille = []
    line.each_char do |letter|
      if @alpha[letter] == @alpha[letter.downcase]
        braille << @alpha[letter.downcase]
      elsif @alpha[letter] == @alpha[letter.upcase]
        braille << @alpha[letter.downcase]
      end
    end
    braille
  end

end