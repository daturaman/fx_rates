require 'open-uri'
require 'rexml/document'
include REXML

class EcbDatasource
  FEED_URI = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'
  attr_reader :feed_uri

  def initialize(f=FEED_URI)
    @feed_uri = f
  end

  def load_and_transform
    fx_xml = Document.new(open(@feed_uri) { |f| f.read })
    fx_map = Hash.new
    fx_xml.each_element('gesmes:Envelope/Cube/Cube') { |time_el|
      per_date = Hash.new
      time_el.each_element('Cube') { |curr_el|
        cur = curr_el.attributes['currency']
        rate = curr_el.attributes['rate'].to_f
        per_date[cur] = rate
      }
      fx_map[time_el.attributes['time']] = per_date
    }
    fx_map
  end
end