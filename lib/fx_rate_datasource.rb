require 'open-uri'

class FxRateDatasource
  FX_FEED_FILE = 'fx_feed_file.xml'

  def get_fx_rate(date, from_cur, to_cur)
    0
  end

  def load_fx_rate(feed_uri)
    fx_feed = open(feed_uri) { |f| f.read }
    File.open(FX_FEED_FILE, 'w') do |feed_file|
      feed_file.puts fx_feed
    end
  end
end