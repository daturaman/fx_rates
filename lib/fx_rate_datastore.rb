require 'open-uri'
require 'rexml/document'
require 'json'
include REXML

class FxRateDatastore
  FX_JSON_FILE = 'fx_rates.json'
  attr_writer :fx_datasource

  def initialize(fx_ds)
    @fx_datasource = fx_ds
    @fx_data = File.exist?(FX_JSON_FILE) ? JSON.parse(File.new(FX_JSON_FILE).read) : load_fx_rate
  end

  def get_fx_rate(date, currency)
    fx_rate = @fx_data[date.to_s]
    (fx_rate.nil? || fx_rate[currency].nil?) ? (raise ArgumentError, "No fx rate found for #{currency} at #{date}") : fx_rate[currency]
  end

  def load_fx_rate
    data = @fx_datasource.load_and_transform
    File.open(FX_JSON_FILE, 'w+') { |f| f.puts(JSON.generate(data)) }
    data
  end
end