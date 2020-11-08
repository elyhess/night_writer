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

  def too_long?(imported_text)
    imported_text.length > 40 
  end

  def create_new_line(imported_text)
    imported_text.chars.each_slice(40).map do |array|
      array.join
    end
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
  
  def format_braille(braille_array)
    letter_pairs = braille_array.map do |string|
      string.chars.each_slice(2).to_a
    end
    each_line = letter_pairs.transpose.map do |line|
      line.join
    end.join("\n")
  end

  def english_to_braille
    create_new_line(imported_text).reduce("") do |translation, line|
      if too_long?(imported_text)
        translation += (format_braille(convert_to_braille(line)) + "\n")
      else 
        translation += (format_braille(convert_to_braille(line)))
      end
    end 
  end

end