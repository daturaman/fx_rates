require 'date'
require 'fx_rate_datasource'

class FxRate
  class << self
    def at(date, from_currency, to_currency)
      #TODO Decide how and when to instantiate the datasource and read the web feed to file
      fx_data = FxRateDatasource.new('http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml')
      from_fx_rate = fx_data.get_fx_rate(date, from_currency) # eur to 'to_currency'
      to_fx_rate = fx_data.get_fx_rate(date, to_currency) # eur to 'from_currency'
      1/(from_fx_rate.to_f/to_fx_rate.to_f)
    end
  end
end