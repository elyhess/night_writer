require_relative '../test/test_helper'
require_relative '../lib/reader'
require_relative '../lib/alphabet'
class WriterTest < Minitest::Test

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
    writer = Writer.new(@input_file, @output_file)
    writer.stubs(:imported_text).returns("hello world")
    assert_output("Created './braille.txt' containing 11 characters.\n") {writer.export}
  end

end