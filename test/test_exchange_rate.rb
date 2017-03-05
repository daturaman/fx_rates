require 'test/unit'
require 'date'
require_relative '../lib/exchange_rate'

class ExchangeRateTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_should_convert_from_gbp_to_usd
    expected_fx_rate = 1.229#TODO This isn't the exact figure
    assert_equal(expected_fx_rate, ExchangeRate.at(Date.new(2017, 03, 02), "GBP", "USD"))
  end
end