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
    0
  end

  private
  def load_fx_rate(feed_uri)
    fx_feed = open(feed_uri) { |f| f.read }
    feed_file = File.open(FX_FEED_FILE, 'w') do |feed_file|
      feed_file.puts fx_feed
    end
    #THis should create the xml dom instance field
    @fx_xml = Document.new(feed_file)
  end
end