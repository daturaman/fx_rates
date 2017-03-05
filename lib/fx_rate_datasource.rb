require 'open-uri'
require 'rexml/document'
include REXML

class FxRateDatasource
  FX_FEED_FILE = 'fx_feed_file.xml'
  attr_reader :fx_xml

  def initialize(feed_uri)
    @feed_uri = feed_uri
    @fx_xml = nil
    unless File.exist?(FX_FEED_FILE) #Potential bug/flaw - could use old data.
      load_fx_rate(@feed_uri)
    end
  end

  def get_fx_rate(date, to_cur)
    XPath.first(@fx_xml, "//Cube[@time='2017-03-02']/Cube[@currency='GBP']")
  end

  private
  def load_fx_rate(feed_uri)
    fx_feed = open(feed_uri) { |f| f.read }
    feed_file = File.open(FX_FEED_FILE, 'w+')
    feed_file.puts(fx_feed)
    @fx_xml = Document.new(File.new(feed_uri)) #FIXME
    feed_file.close
  end
end