require 'open-uri'
require 'rexml/document'
include REXML

class FxRateDatasource
  FX_FEED_FILE = 'fx_feed_file.xml'
  attr_reader :fx_xml

  def initialize(feed_uri)
    @feed_uri = feed_uri
    #BUG - need way to update file, even if it exists
    @fx_xml = File.exist?(FX_FEED_FILE) ? Document.new(File.new(FX_FEED_FILE)) : load_fx_rate(@feed_uri)
  end

  def get_fx_rate(date, currency)
    element = XPath.first(@fx_xml, "//Cube[@time='#{date}']/Cube[@currency='#{currency}']") #TODO make this xpath settable
    element.nil? ? (raise ArgumentError, "No fx rate found for #{currency} at #{date}") : element['rate']
  end

  def load_fx_rate(feed_uri)
    fx_feed = open(feed_uri) { |f| f.read }
    feed_file = File.open(FX_FEED_FILE, 'w+')
    feed_file.puts(fx_feed)
    feed_file.close
    Document.new(fx_feed)
  end
end