require 'test/unit'
require 'date'
require 'exchange_rate'

class TestExchangeRate < Test::Unit::TestCase
  def teardown
    if File.exist?(FxRateDatastore::FX_JSON_FILE)
      File.delete(FxRateDatastore::FX_JSON_FILE)
    end
  end

  def test_should_convert_from_gbp_to_usd
    expected_fx_rate = 1.228845255
    actual_fx_rate = ExchangeRate.at(Date.new(2017, 03, 02), 'GBP', 'USD')
    precision = 3
    assert_equal(expected_fx_rate.round(precision), actual_fx_rate.round(precision))
  end

  def test_should_convert_from_aud_to_huf
    expected_fx_rate = 222.781800598
    actual_fx_rate = ExchangeRate.at(Date.new(2017, 03, 02), 'AUD', 'HUF')
    precision = 3
    assert_equal(expected_fx_rate.round(precision), actual_fx_rate.round(precision))
  end
end