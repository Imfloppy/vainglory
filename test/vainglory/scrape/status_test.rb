require 'test_helper'
require 'vainglory/scrape/status'

class StatusTest < Minitest::Test
  def test_initialize
    status = Vainglory::Status.new("hp", 100, 2)
    assert_equal("hp", status.name)
    assert_equal(100, status.start)
    assert_equal(2, status.glow)

    assert_raises do
      Vainglory::Status.new
    end
    assert_raises do
      Vainglory::Status.new("hp")
    end
    assert_raises do
      Vainglory::Status.new("hp", 100)
    end
  end

  def test_convert_status_name
    actual = Vainglory::Status.convert_status_name("ヒットポイント(HP)")
    assert_equal("hp", actual)
    actual = Vainglory::Status.convert_status_name("HP再生")
    assert_equal("hp_regen", actual)
    actual = Vainglory::Status.convert_status_name("エナジーポイント(EP)")
    assert_equal("ep", actual)
    actual = Vainglory::Status.convert_status_name("EP回復")
    assert_equal("ep_regen", actual)
    actual = Vainglory::Status.convert_status_name("武器ダメージ")
    assert_equal("weapon_damage", actual)
    actual = Vainglory::Status.convert_status_name("攻撃速度")
    assert_equal("attack_speed", actual)
    actual = Vainglory::Status.convert_status_name("アーマー")
    assert_equal("armor", actual)
    actual = Vainglory::Status.convert_status_name("シールド")
    assert_equal("shield", actual)
    actual = Vainglory::Status.convert_status_name("攻撃範囲")
    assert_equal("attack_range", actual)
    actual = Vainglory::Status.convert_status_name("Movement Speed")
    assert_equal("move_speed", actual)
    
    actual = Vainglory::Status.convert_status_name("")
    assert_nil(actual)
    actual = Vainglory::Status.convert_status_name("ほげほげ")
    assert_equal("ほげほげ", actual)
  end

  def test_to_hash
    status = Vainglory::Status.new("hp", 100, 2)
    actual = status.to_hash 
    expected = {hp: {start: 100, glow: 2}}
    assert_equal(expected, actual)
  end
end
