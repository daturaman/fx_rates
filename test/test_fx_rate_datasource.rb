require 'test/unit'
require_relative '../lib/fx_rate_datasource'

class TestFxRateDatasource < Test::Unit::TestCase
  TEST_FEED = 'eurofxref-hist-90d.xml'

  def teardown
    if File.exist?(FxRateDatasource::FX_FEED_FILE)
      File.delete(FxRateDatasource::FX_FEED_FILE)
    end
  end

  def test_loads_fx_feed_to_local_file
    FxRateDatasource.new(TEST_FEED)
    test_feed_file = IO.readlines(TEST_FEED)
    #Compare expected and actual feed files, line by line
    IO.readlines(FxRateDatasource::FX_FEED_FILE).each_with_index do |line, line_num|
      assert_equal(test_feed_file[line_num], line)
    end
  end

  #TODO Parameterise this
  def test_returns_fx_rate
    data = FxRateDatasource.new(TEST_FEED)
    actual_fx_rate = data.get_fx_rate(Date.new(2017, 03, 02), 'GBP')
    assert_equal(0.8556.to_s, actual_fx_rate)
  end
end