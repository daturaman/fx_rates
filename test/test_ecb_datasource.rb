require 'test-unit'
require 'ecb_datasource'
require 'json'

class TestEcbDatasource < Test::Unit::TestCase
  TEST_FEED = 'ecb_test_feed.xml'

  def test_transforms_xml_to_json
    actual_fx_json = EcbDatasource.new(TEST_FEED).load_and_transform
    expected_json = File.read('ecb_test.json')
    assert_equal(JSON.parse(expected_json), actual_fx_json)
  end
end