module Scrape
  class Status
    def initialize
      status = nil
      start = nil
      glow = nil
    end

    attr_accessor :status, :start, :glow

    def self.convert_status_name(status_name)
      case status_name
      when "ヒットポイント(HP)" then
        "hp"
      when "HP再生" then
        "hp_regen"
      when "エナジーポイント(EP)" then
        "ep"
      when "EP回復" then
        "ep_regen"
      when "武器ダメージ" then
        "weapon_damage"
      when "攻撃速度" then
        "attack_speed"
      when "アーマー" then
        "armor"
      when "シールド" then
        "shield"
      when "攻撃範囲" then
        "attack_range"
      when "Movement Speed" then
        "move_speed"
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
      array = []
      instance_variables.each do |variable|
        key = variable.to_s.tr('@', '')
        value = instance_variable_get(variable)
        array.push({key.to_sym => value})
      end
      array
    end
  end
end