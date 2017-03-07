require 'test-unit'
require 'ecb_fx_data'
require 'json'

class TransformEcbDataTest < Test::Unit::TestCase
  TEST_FEED = 'ecb_test_feed.xml'

  def test_transforms_xml_to_json
    actual_fx_json = EcbFxData.new(TEST_FEED).transform
    expected_json = File.read('ecb_test.json')
    assert_equal(JSON.parse(expected_json), JSON.load(actual_fx_json))
  end
end