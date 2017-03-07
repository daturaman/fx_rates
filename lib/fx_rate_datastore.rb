require 'open-uri'
require 'rexml/document'
include REXML

class FxRateDatastore #TODO call this datastore
  FX_FEED_FILE = 'fx_feed_file.xml'
  FX_JSON = 'fx_rates.json'

  def initialize(feed_uri) #TODO pass in a DataSource (e.g.ECB)
    #BUG - need way to update file, even if it exists
    @fx_xml = File.exist?(FX_FEED_FILE) ? Document.new(File.new(FX_FEED_FILE)) : load_fx_rate(feed_uri)
  end

  #TODO This should only ever read from the json file
  def get_fx_rate(date, currency)
    element = XPath.first(@fx_xml, "//Cube[@time='#{date}']/Cube[@currency='#{currency}']")
    element.nil? ? (raise ArgumentError, "No fx rate found for #{currency} at #{date}") : element.attribute('rate').value
  end

  def load_fx_rate(feed_uri)
    fx_feed = open(feed_uri) { |f| f.read } # fx_feed_data = fx_data.transform
    feed_file = File.open(FX_FEED_FILE, 'w+')
    #TODO convert to json here - rename feed_file as it is confusing
    feed_file.puts(fx_feed)
    feed_file.close
    Document.new(fx_feed)
  end
end