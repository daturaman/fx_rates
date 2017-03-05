require 'test/unit'
require_relative '../lib/fx_rate_datasource'

class TestFxRateDatasource < Test::Unit::TestCase
  TEST_FEED_FILE = IO.readlines('eurofxref-hist-90d.xml')
  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    File.delete(FxRateDatasource::FX_FEED_FILE)
  end

  def test_loads_fx_feed_to_local_file
    FxRateDatasource.new.load_fx_rate('eurofxref-hist-90d.xml')
    IO.readlines(FxRateDatasource::FX_FEED_FILE).each_with_index do |line, line_num|
      puts "#{line_num}: #{line}"
      assert_equal(TEST_FEED_FILE[line_num], line)
    end
  end

  #def test
end