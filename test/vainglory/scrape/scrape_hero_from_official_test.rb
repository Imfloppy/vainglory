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

  def test_float_from_match
    actual = @scrapeHeroFromOfficial.send(:get_float_from_match, '123'.match('\D'))
    assert_nil(actual)

    actual = @scrapeHeroFromOfficial.send(:get_float_from_match, '[123]'.match('(\d+)'))
    assert_equal(123, actual)

    actual = @scrapeHeroFromOfficial.send(:get_float_from_match, '123'.match('\d+'))
    assert_equal(123, actual)
  end
end
