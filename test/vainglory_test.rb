require 'test_helper'

class VaingloryTest < Minitest::Test
  def test_version
    refute_nil ::Vainglory::VERSION
  end

  def test_hero_instance
    koshka = Vainglory.hero :koshka
    assert_instance_of Vainglory::Hero, koshka
  end

  def test_invalid_name
    e = assert_raises Vainglory::HeroNameError do
      Vainglory.hero 'aiueo'
    end
    assert_match(/Invalid hero name/, e.message)
  end

  def test_set_level
    koshka = Vainglory.hero :koshka
    koshka.level = 1
    assert_equal koshka.level, 1
    assert_equal koshka.hp, 761
    assert_equal koshka.attack_range, 1.7
    koshka.level = 12
    assert_equal koshka.level, 12
    assert_equal koshka.attack_range, 1.7
    assert_equal koshka.hp, 1498
  end

  def test_set_ability
    rona = Vainglory.hero :rona
    assert_equal "berserkers'_fury", rona.ability[0][:name]
    assert_equal "into_the_fray", rona.ability[1][:name]
    assert_equal 16, rona.ability[1][:cool_down][:effect][3]
  end

  def test_fetch_hp_list_in_all_heroes
    koshka = Vainglory.hero :koshka
    koshka.level = 5

    hp_list_in_all_heroes = Vainglory.status :hp
    hp_list_at_level_12_in_order_desc = [
      { name: 'glaive', hp: 2046.0 },
      { name: 'rona', hp: 1789.0 },
      { name: 'joule', hp: 1705.0 },
      { name: 'adagio', hp: 1654.0 },
      { name: 'ardan', hp: 1615.0 },
      { name: 'skye', hp: 1563.0 },
      { name: 'fortress', hp: 1560.0 },
      { name: 'taka', hp: 1555.0 },
      { name: 'catherine', hp: 1509.0 },
      { name: 'krul', hp: 1501.0 },
      { name: 'koshka', hp: 1498.0 },
      { name: 'vox', hp: 1465.0 },
      { name: 'petal', hp: 1453.0 },
      { name: 'saw', hp: 1453.0 },
      { name: 'ringo', hp: 1405.0 },
      { name: 'celeste', hp: 1347.0 },
      { name: 'skaarf', hp: 1347.0 }
    ]
    assert_equal hp_list_at_level_12_in_order_desc, hp_list_in_all_heroes

    hp_list_in_all_heroes = Vainglory.status :hp, 12, :desc
    assert_equal hp_list_at_level_12_in_order_desc, hp_list_in_all_heroes

    hp_list_in_all_heroes = Vainglory.status :hp, 12, :asc
    hp_list_at_level_12_in_order_asc = [
      { name: 'celeste', hp: 1347.0 },
      { name: 'skaarf', hp: 1347.0 },
      { name: 'ringo', hp: 1405.0 },
      { name: 'petal', hp: 1453.0 },
      { name: 'saw', hp: 1453.0 },
      { name: 'vox', hp: 1465.0 },
      { name: 'koshka', hp: 1498.0 },
      { name: 'krul', hp: 1501.0 },
      { name: 'catherine', hp: 1509.0 },
      { name: 'taka', hp: 1555.0 },
      { name: 'fortress', hp: 1560.0 },
      { name: 'skye', hp: 1563.0 },
      { name: 'ardan', hp: 1615.0 },
      { name: 'adagio', hp: 1654.0 },
      { name: 'joule', hp: 1705.0 },
      { name: 'rona', hp: 1789.0 },
      { name: 'glaive', hp: 2046.0 }
    ]
    assert_equal hp_list_at_level_12_in_order_asc, hp_list_in_all_heroes

    hp_list_in_all_heroes = Vainglory.status :hp, 5
    hp_list_at_lelvel_5_in_order_desc = [
      { name: 'glaive', hp: 1262.0 },
      { name: 'rona', hp: 1159.0 },
      { name: 'joule', hp: 1110.0 },
      { name: 'ardan', hp: 1097.0 },
      { name: 'adagio', hp: 1059.0 },
      { name: 'catherine', hp: 1040.0 },
      { name: 'taka', hp: 1037 },
      { name: 'koshka', hp: 1029.0 },
      { name: 'fortress', hp: 986 },
      { name: 'skye', hp: 982.0 },
      { name: 'vox', hp: 975.0 },
      { name: 'petal', hp: 956.0 },
      { name: 'saw', hp: 956.0 },
      { name: 'krul', hp: 955.0 },
      { name: 'ringo', hp: 922.0 },
      { name: 'celeste', hp: 892.0 },
      { name: 'skaarf', hp: 892.0 }
    ]
    assert_equal hp_list_at_lelvel_5_in_order_desc, hp_list_in_all_heroes

    assert_equal koshka.level, 5
  end

  def test_fetch_ability_list_in_all_heroes
    heighest_damage = { name: 'verse_of_judgement', level: 3, damage: 910 }

    damage_list_in_all_heroes = Vainglory.ability :damage
    assert_equal heighest_damage, damage_list_in_all_heroes[0]

    damage_list_in_all_heroes = Vainglory.ability :damage, :desc
    assert_equal heighest_damage, damage_list_in_all_heroes[0]

    earliest_cool_down = { name: 'heliogenesis', level: 5, cool_down: 1 }
    cool_down_list_in_all_heroes = Vainglory.ability :cool_down, :asc
    assert_equal earliest_cool_down, cool_down_list_in_all_heroes[0]
  end
end
