require 'rexml/document'
require 'json'
include REXML

class FxRateDatastore
  attr_reader :fx_datasource

  def initialize(fx_datasource)
    @fx_datasource = fx_datasource
    load_fx_rate
  end

  def get_fx_rate(date, currency)
    fx_rate = @fx_data[date.to_s]
    (fx_rate.nil? || fx_rate[currency].nil?) ? (raise ArgumentError, "No fx rate found for #{currency} at #{date}") : fx_rate[currency]
  end

  def fx_datasource=(fx_datasource)
    @fx_datasource = fx_datasource
    @fx_data = nil # must do this when changing datasource or we will be using the old data
    load_fx_rate
  end

  def load_fx_rate
    #if fx_data.nil? || fx_data.latest_date < Date.today then reload fx_data from datasource. Datasource always reads from xml file. 
    #Cron job reads from the web feed
    @fx_data = @fx_datasource.load_and_transform
  end
end
