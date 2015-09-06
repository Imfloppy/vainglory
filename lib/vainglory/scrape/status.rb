module Vainglory
  class Status
    def initialize(name, start, glow)
      self.name = name
      self.start = start
      self.glow = glow
    end

    attr_accessor :name, :start, :glow

    def self.convert_status_name(status_name)
      case status_name
      when "ヒットポイント(HP)", "Hit Points(HP)"
        "hp"
      when "HP再生", "HP Regen"
        "hp_regen"
      when "エナジーポイント(EP)", "Energy Points(EP)"
        "ep"
      when "EP回復", "EP Regen"
        "ep_regen"
      when "武器ダメージ", "Weapon Damage"
        "weapon_damage"
      when "攻撃速度", "Attack Speed"
        "attack_speed"
      when "アーマー", "Armor"
        "armor"
      when "シールド", "Shield"
        "shield"
      when "攻撃範囲", "Attack Range"
        "attack_range"
      when "Movement Speed"
        "move_speed"
      when ""
        nil
      else
        status_name
      end
    end

    def name=(status_name)
      @name = Status.convert_status_name(status_name)
    end

    def start=(value)
      @start = value
    end

    def glow=(value)
      @glow = value
    end

    def to_hash
      hash = Hash.new
      hash.store(@name.to_sym, {start: @start, glow: @glow})
      hash
    end
  end
end
