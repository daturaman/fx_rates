require 'date'
require 'fx_rate_datastore'
require 'ecb_datasource'
require 'open-uri'

module ExchangeRate
  module_function
  @datastore = FxRateDatastore.new(EcbDatasource.new)

  def self.datasource=(datasource)
    @datastore.fx_datasource = datasource
  end

  def at(date, from_currency, to_currency)
    from_fx_rate = @datastore.get_fx_rate(date, from_currency)
    to_fx_rate = @datastore.get_fx_rate(date, to_currency)
    1/(from_fx_rate.to_f/to_fx_rate.to_f)
  end

  #This can be called by a cron job
  def load_fx_data(feed_uri)
    #Update the local file that datastore.datasource reads from e.g.'http://www.ecb.europa.eu/stats/eurofxref/fx_data.xml'
    fx_data = open(feed_uri) { |f| f.read }
    File.open(@datastore.fx_datasource::FX_DATA, 'w+') { |f| f.puts(fx_data) }
    @datastore.load_fx_rate
  end
end