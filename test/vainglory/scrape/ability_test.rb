require 'test_helper'
require 'vainglory/scrape/ability'

class AbilityTest < Minitest::Test
  def test_initialize
    ability = Vainglory::Ability.new("ケンカ上等", "飛びかかる")
    assert_equal("ケンカ上等", ability.name)
    assert_equal("飛びかかる", ability.effect)

    assert_raises do
      Vainglory::Ability.new("ケンカ上等")
    end
  end

  def to_hash
    ability = Vainglory::Ability.new(:into_the_fray, "飛びかかる")
    actual = ability.to_hash
    expected = {into_the_fray: {effect: "飛びかかる"}}
    assert_equal(expected, actual)
  end
end
