require 'test/unit'
require 'date'
require_relative '../lib/exchange_rate'

class ExchangeRateTest < Test::Unit::TestCase
  def test_should_convert_from_gbp_to_usd
    expected_fx_rate = 1.229 #TODO This isn't the exact figure
    assert_equal(expected_fx_rate, ExchangeRate.at(Date.new(2017, 03, 02), 'GBP', 'USD'))
  end
end