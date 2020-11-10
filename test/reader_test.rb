require_relative '../test/test_helper'
require_relative '../lib/reader'
require_relative '../lib/alphabet'
class ReaderTest < Minitest::Test

  def setup
    @input_file = './braille.txt'
    @output_file = './original_message.txt'
  end

  def test_it_exists_and_has_attributes
    reader = Reader.new(@input_file, @output_file)
    
    assert_instance_of Reader, reader
    assert_equal @input_file, reader.imported_braille
    assert_equal @output_file, reader.output
    assert_instance_of Hash, reader.alpha
  end

  def test_terminal_output
    reader = Reader.new(@input_file, @output_file)
    reader.stubs(:braille_lines).returns(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])
    assert_output("Created './original_message.txt' containing 11 characters.\n") {reader.export}
  end

  def test_it_adds_braille
    reader = Reader.new(@input_file, @output_file)
    reader.stubs(:imported_braille).returns(["0.0.0.0.0....00.0.0.00\n", "00.00.0..0..00.0000..0\n", "....0.0.0....00.0.0..."])
    expected = ["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."]
    assert_equal expected, reader.braille_lines
  end

  def test_it_slices_to_pairs
    reader = Reader.new(@input_file, @output_file)
    reader.stubs(:braille_lines).returns(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])
    expected = [[["0", "."], ["0", "."], ["0", "."], ["0", "."], ["0", "."], [".", "."], [".", "0"], ["0", "."], ["0", "."], ["0", "."], ["0", "0"]],[["0", "0"], [".", "0"], ["0", "."], ["0", "."], [".", "0"], [".", "."], ["0", "0"], [".", "0"], ["0", "0"], ["0", "."], [".", "0"]],[[".", "."], [".", "."], ["0", "."], ["0", "."], ["0", "."], [".", "."], [".", "0"], ["0", "."], ["0", "."], ["0", "."], [".", "."]]]
    assert_equal expected, reader.slice_to_pairs(reader.braille_lines)
  end

  def test_it_formats
    reader = Reader.new(@input_file, @output_file)
    reader.stubs(:braille_lines).returns(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])
    expected = ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0.."]
    assert_equal expected, reader.format(reader.braille_lines)
  end

  def test_it_maps_to_braille
    reader = Reader.new(@input_file, @output_file)
    reader.stubs(:imported_braille).returns(["0.0.0.0.0....00.0.0.00\n", "00.00.0..0..00.0000..0\n", "....0.0.0....00.0.0..."])
    expected = ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0.."]
    assert_equal expected, reader.map_braille(reader.braille_lines)

    reader = Reader.new(@input_file, @output_file)
    reader.stubs(:imported_braille).returns(["0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n","................................................................................\n","................................................................................\n","0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n","................................................................................\n","................................................................................\n","0.\n","..\n","..\n"])
    expected = ["0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0.....", "0....."]
    assert_equal expected, reader.map_braille(reader.braille_lines)
  end

  def test_it_converts_braille_to_english
    reader = Reader.new(@input_file, @output_file)
    reader.stubs(:imported_braille).returns(["0.0.0.0.0....00.0.0.00\n", "00.00.0..0..00.0000..0\n", "....0.0.0....00.0.0..."])
    expected = "hello world"
    assert_equal expected, reader.braille_to_english
  end

  def test_it_makes_new_line
    reader = Reader.new(@input_file, @output_file)
    expected = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\na"
    assert_equal expected, reader.new_line("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 80)
  end
  
end