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
    reader = Reader.new(@input_file, @output_file)
    reader.stubs(:remove_newlines).returns(["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."])
    assert_output("Created './original_message.txt' containing 11 characters.\n") {reader.export}
  end

end