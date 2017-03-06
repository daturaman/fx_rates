require 'test/unit'
require 'date'
require_relative '../lib/exchange_rate'

class ExchangeRateTest < Test::Unit::TestCase
  def test_should_convert_from_gbp_to_usd
    #TODO Mock FxRateDatasource?
    expected_fx_rate = 1.228845255
    actual_fx_rate = ExchangeRate.at(Date.new(2017, 03, 02), 'GBP', 'USD')
    precision = 3
    assert_equal(expected_fx_rate.round(precision), actual_fx_rate.round(precision))
  end
end