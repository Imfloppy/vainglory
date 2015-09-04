require 'test_helper'

class ScrapeHeroFromOfficialTest < Minitest::Test
  def setup
    ardan_url = 'http://jp.vainglorygame.com/hero/rona/'
    @scrapeHeroFromOfficial = Vainglory::ScrapeHeroFromOfficial.new(ardan_url)
  end

  def test_match_status_string
    regex = /\d+/
    actual = @scrapeHeroFromOfficial.send(:match_status_string, '', regex)
    assert_equal("Not Written", actual)

    actual = @scrapeHeroFromOfficial.send(:match_status_string, 'N/A', regex)
    assert(actual.nan?)

    actual = @scrapeHeroFromOfficial.send(:match_status_string, '12', regex)
    refute_equal("Not Written", actual)
    refute_equal(Float::NAN, actual)
  end
end
