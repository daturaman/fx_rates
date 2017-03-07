require 'open-uri'
require 'rexml/document'
include REXML

class EcbDatasource
  FEED_URI = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'
  attr_reader :feed_uri

  def initialize(feed_uri=FEED_URI)
    @feed_uri = feed_uri
  end

  def load_and_transform
    fx_xml = Document.new(open(@feed_uri) { |f| f.read })
    fx_map = Hash.new
    fx_xml.each_element('gesmes:Envelope/Cube/Cube') { |time_element|
      per_date = Hash.new
      time_element.each_element('Cube') { |currency_element|
        currency = currency_element.attributes['currency']
        rate = currency_element.attributes['rate'].to_f
        per_date[currency] = rate
      }
      fx_map[time_element.attributes['time']] = per_date
    }
    fx_map
  end
end