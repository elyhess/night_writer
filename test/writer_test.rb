require_relative '../test/test_helper'
require_relative '../lib/writer'
require_relative '../lib/alphabet'
class WriterTest < Minitest::Test

  def setup
    @input_file = './message.txt'
    @output_file = './braille.txt'
  end

  def test_it_exists_and_has_attributes
    writer = Writer.new(@input_file, @output_file)
    
    assert_instance_of Writer, writer
    assert_equal @input_file, writer.imported_text
    assert_equal @output_file, writer.output
    assert_instance_of Hash, writer.alpha
  end

  def test_export_and_terminal_output
    writer = Writer.new(@input_file, @output_file)
    writer.stubs(:imported_text).returns("hello world")
    assert_output("Created './braille.txt' containing 11 characters.\n") {writer.export}
  end

  def test_it_knows_if_text_is_too_long
    writer = Writer.new(@input_file, @output_file)

    writer.stubs(:imported_text).returns("hello world")
    assert_equal false, writer.too_long?(writer.imported_text)

    writer.stubs(:imported_text).returns("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
    assert_equal true, writer.too_long?(writer.imported_text)
  end

  def test_it_will_seperate_new_line_at_40_chars
    writer = Writer.new(@input_file, @output_file)

    writer.stubs(:imported_text).returns("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
    expected = ["aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", "a"]
    assert_equal expected, writer.new_line(writer.imported_text, 40)
    writer.stubs(:imported_text).returns("hello world")
    expected = ["hello world"]
    assert_equal expected, writer.new_line(writer.imported_text, 40)
  end 

  def test_it_will_slice_to_pairs
    writer = Writer.new(@input_file, @output_file)
    writer.stubs(:convert_to_braille).returns(["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0.."])
    expected = [[["0", "."], ["0", "0"], [".", "."]],[["0", "."], [".", "0"], [".", "."]],[["0", "."], ["0", "."], ["0", "."]],[["0", "."], ["0", "."], ["0", "."]],[["0", "."], [".", "0"], ["0", "."]],[[".", "."], [".", "."], [".", "."]],[[".", "0"], ["0", "0"], [".", "0"]],[["0", "."], [".", "0"], ["0", "."]],[["0", "."], ["0", "0"], ["0", "."]],[["0", "."], ["0", "."], ["0", "."]],[["0", "0"], [".", "0"], [".", "."]]]
    assert_equal expected, writer.slice_to_pairs(writer.convert_to_braille)
  end

  def test_it__converts_lines_to_braille
    writer = Writer.new(@input_file, @output_file)
    writer.stubs(:imported_text).returns("Hello world")
    expected = ["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0.."]
    assert_equal expected, writer.convert_to_braille(writer.imported_text)
  end

  def test_it_will_format_braille
    writer = Writer.new(@input_file, @output_file)
    writer.stubs(:convert_to_braille).returns(["0.00..", "0..0..", "0.0.0.", "0.0.0.", "0..00.", "......", ".000.0", "0..00.", "0.000.", "0.0.0.", "00.0.."])
    expected = "0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0..."
    assert_equal expected, writer.format_braille(writer.convert_to_braille)
  end

  def test_it_turns_english_into_braille
    writer = Writer.new(@input_file, @output_file)

    writer.stubs(:imported_text).returns("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
    expected = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................\n0.\n..\n..\n"
    assert_equal expected, writer.english_to_braille

    writer.stubs(:imported_text).returns("hello world")
    expected = "0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0..."
    assert_equal ["hello world"], writer.new_line(writer.imported_text, 40)

    assert_equal expected, writer.english_to_braille
  end

end