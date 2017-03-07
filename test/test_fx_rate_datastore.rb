require 'test/unit'
require_relative '../lib/fx_rate_datastore'

class TestFxRateDatastore < Test::Unit::TestCase
  TEST_FEED = 'eurofxref-hist-90d.xml'

  def teardown
    if File.exist?(FxRateDatastore::FX_FEED_FILE)
      File.delete(FxRateDatastore::FX_FEED_FILE)
    end
  end

  def test_loads_fx_feed_to_local_file
    FxRateDatastore.new(TEST_FEED)
    test_feed_file = IO.readlines(TEST_FEED)
    #Compare expected and actual feed files, line by line
    IO.readlines(FxRateDatastore::FX_FEED_FILE).each_with_index do |line, line_num|
      assert_equal(test_feed_file[line_num], line)
    end
  end

  #I would have used a parameterised test here, but didn't know how to do it in Ruby

  def test_returns_fx_rate_gbp
    data = FxRateDatastore.new(TEST_FEED)
    actual_fx_rate = data.get_fx_rate(Date.new(2017, 03, 02), 'GBP')
    assert_equal(0.8556.to_s, actual_fx_rate)
  end

  def test_returns_fx_rate_usd
    data = FxRateDatastore.new(TEST_FEED)
    actual_fx_rate = data.get_fx_rate(Date.new(2017, 03, 02), 'USD')
    assert_equal(1.0514.to_s, actual_fx_rate)
  end

  def test_returns_fx_rate_jpy
    data = FxRateDatastore.new(TEST_FEED)
    actual_fx_rate = data.get_fx_rate(Date.new(2017, 03, 02), 'JPY')
    assert_equal(120.24.to_s, actual_fx_rate)
  end

  def test_invalid_date_throws_exception
    assert_raise ArgumentError do
      FxRateDatastore.new(TEST_FEED).get_fx_rate(Date.new(2012, 12, 21), 'HUF')
    end
  end
end