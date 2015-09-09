require 'test_helper'

class VaingloryTest < Minitest::Test
  def test_version
    refute_nil ::Vainglory::VERSION
  end

  def test_hero_instance
    koshka = Vainglory.hero :コシュカ
    assert_instance_of Vainglory::Hero, koshka
  end

  def test_invalid_name
    e = assert_raises Vainglory::HeroNameError do
      Vainglory.hero 'aiueo'
    end
    assert_match(/Invalid hero name/, e.message)
  end

  def test_set_level
    koshka = Vainglory.hero :コシュカ
    assert_equal koshka.level, 1
    koshka.level = 12
    assert_equal koshka.level, 12
    assert_equal koshka.hp, 1498
  end
end
