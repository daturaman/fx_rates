require 'test/unit'
require 'ecb_datasource'
require_relative '../lib/fx_rate_datastore'

class TestFxRateDatastore < Test::Unit::TestCase
  def setup
    @data = FxRateDatastore.new(EcbDatasource.new)
  end

  def test_returns_fx_rate_gbp
    actual_fx_rate = @data.get_fx_rate(Date.new(2017, 03, 02), 'GBP')
    assert_equal(0.8556, actual_fx_rate)
  end

  def test_returns_fx_rate_usd
    actual_fx_rate = @data.get_fx_rate(Date.new(2017, 03, 02), 'USD')
    assert_equal(1.0514, actual_fx_rate)
  end

  def test_returns_fx_rate_jpy
    actual_fx_rate = @data.get_fx_rate(Date.new(2017, 03, 02), 'JPY')
    assert_equal(120.24, actual_fx_rate)
  end

  def test_date_out_of_range
    assert_raise ArgumentError do
      @data.get_fx_rate(Date.new(2012, 12, 21), 'HUF')
    end
  end
end