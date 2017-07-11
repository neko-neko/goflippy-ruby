require 'test_helper'

class GoFlippyTest < Minitest::Test
  def test_that_it_has_a_version_number
    assert_match(/\d+.\d+.\d+/, GoFlippy::VERSION)
  end
end
