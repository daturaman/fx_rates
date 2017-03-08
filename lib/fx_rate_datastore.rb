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
    load_fx_rate
  end

  def load_fx_rate
    @fx_data = @fx_datasource.load_and_transform
  end
end