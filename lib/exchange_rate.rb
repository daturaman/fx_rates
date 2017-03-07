require 'date'
require 'fx_rate_datastore'
require 'ecb_datasource'

module ExchangeRate
  module_function
  @datastore = FxRateDatastore.new(EcbDatasource.new)

  def self.datasource=(ds)
    @datastore.fx_datasource = ds
  end

  def at(date, from_currency, to_currency)
    from_fx_rate = @datastore.get_fx_rate(date, from_currency)
    to_fx_rate = @datastore.get_fx_rate(date, to_currency)
    1/(from_fx_rate.to_f/to_fx_rate.to_f)
  end

  def load_fx_data
    @datastore.load_and_transform
  end
end