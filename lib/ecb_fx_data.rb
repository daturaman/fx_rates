require 'open-uri'
require 'rexml/document'
require 'json'
include REXML

class EcbFxData
  FEED_URI = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'
  attr_reader :feed_uri

  def initialize(f=FEED_URI)
    @feed_uri = f
  end

  def transform
    # read the fx_data from the feed and return a JSON object
    fx_feed = open(feed_uri) { |f| f.read }
    fx_xml = Document.new(fx_feed)
    #Now transform
    fx_map = Hash.new
    fx_xml.each_element('gesmes:Envelope/Cube/Cube') { |e|
      fx_map[e.attributes['time']] = []
      e.each_element('Cube') { |x|
        cur = x.attributes['currency']
        rate = x.attributes['rate'].to_f
        fx_map[e.attributes['time']] << {cur => rate}
      }
    }
    JSON.generate(fx_map)
  end
end