require_relative './alphabet'
class Reader
  attr_reader :imported_braille, :output, :alpha
  
  def initialize(input, output)
    @imported_braille = input 
    @output = output
    @alpha = Alphabet.key.invert
  end

  def export
    File.write(output, braille_to_english)
    puts "Created '#{output}' containing #{remove_newlines.join.length / 6} characters."
  end

  def remove_newlines
    imported_braille.map do |line|
      line.delete("\n")
    end
  end

  def slice_to_chars
    braille_pairs = remove_newlines.map do |string|
      string.chars.each_slice(2).to_a
    end
    each_line = braille_pairs.transpose.map do |line|
      line.join
    end
  end

  def braille_to_english
    array = []
    slice_to_chars.each do |char|
      array << @alpha[char] 
    end
    array.join
  end

end 