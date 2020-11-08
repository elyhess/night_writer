require_relative './alphabet'
class Reader
  attr_reader :imported_braille, :output, :alpha
  
  def initialize(input, output)
    @imported_braille = input 
    @output = output
    @alpha = Alphabet.key.invert
  end

  def export
    File.write(output, imported_braille)
    puts "Created '#{output}' containing #{remove_newlines.join.length / 6} characters."
  end

  def remove_newlines
    imported_braille.map do |line|
      line.delete("\n")
    end
  end

end 