require_relative './alphabet'
require_relative './transformable'
class Writer
  include Transformable
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

  def too_long?
    imported_text.length > 40 
  end

  def convert_to_braille(line)
    line.each_char.reduce([]) do |braille, letter|
      if @alpha[letter] == @alpha[letter.downcase]
        braille << @alpha[letter.downcase]
      elsif @alpha[letter] == @alpha[letter.upcase]
        braille << @alpha[letter.downcase]
      end
    end
  end

  def format_braille(content)
    format(content).join("\n")
  end

  def english_to_braille
    new_line(imported_text, 40).reduce("") do |translation, line|
      if too_long?
        translation += (format_braille(convert_to_braille(line)) + "\n")
      else 
        translation += (format_braille(convert_to_braille(line)))
      end
    end 
  end

end