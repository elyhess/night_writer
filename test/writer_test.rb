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
  
end