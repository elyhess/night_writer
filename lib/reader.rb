require_relative './alphabet'
require_relative './transformable'
class Reader
  include Transformable
  attr_reader :imported_braille, :output, :alpha
  
  def initialize(input, output)
    @imported_braille = input 
    @output = output
    @alpha = Alphabet.key.invert
  end

  def export
    File.write(output, braille_to_english)
    puts "Created '#{output}' containing #{braille_lines.join.length / 6} characters."
  end

  def braille_lines
    imported_braille.map do |line|
      line.delete("\n")
    end
  end

  def map_braille(lines)
    min, max, range = 0, 2, 3
    lines.reduce([]) do |collector, line|
      collector << format(braille_lines[min..max]) unless braille_lines[min..max].nil?
      min = max + 1
      max = max + range
      collector
    end.flatten
  end

  def braille_to_english
    english = map_braille(braille_lines).reduce([]) do |collector, char|
      collector << @alpha[char] 
    end.join
    new_line(english, 80)
  end

end 