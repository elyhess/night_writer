require_relative '../test/test_helper'
require_relative '../lib/alphabet'

class AlphabetTest < Minitest::Test

  def test_it_exists_and_has_attributes
    assert_equal Hash, Alphabet.key.class
  end

end