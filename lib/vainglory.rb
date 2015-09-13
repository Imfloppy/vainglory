require 'vainglory/version'
require 'vainglory/hero'
require 'vainglory/file'

module Vainglory
  class HeroNameError < StandardError; end

  class << self
    attr_accessor :heroes

    def hero(name = nil)
      @heroes.fetch(name)
    rescue KeyError
      raise HeroNameError, 'Invalid hero name'
    end

    def init
      self.heroes = {}
      heroes_data = File.load_data('heroes_status.yml')
      heroes_data.each do |name, status|
        heroes[name] = Hero.new(name.to_s, status)
      end

      heroes_ability = YAML::load_file('data/heroes_ability.yml')
      self.heroes.each do |self_hero_name, self_hero_value|
        heroes_ability.each do |target_hero_name, abilities|
          if self_hero_name == target_hero_name
            abilities.each do |ability_name, ability_value|
              ability = { name: ability_name.to_s }
              # パッシブアビリティがまだ未入力のためnilか確認
              ability.merge!(ability_value) if !ability_value.nil?
              self_hero_value.ability << ability
            end
            break
          end
        end
      end
    end

    def status(status_name, level = 12, order = :desc)
      status_list = []
      status_name_symbol = status_name.to_sym
      self.heroes.each_value do |hero|
        before_level = hero.level
        hero.level = level
        status_hash = {}
        status_hash[:name] = hero.name
        status_hash[status_name_symbol] = hero.send(status_name)
        status_list << status_hash
        hero.level = before_level
      end

      status_list.sort! do |hero_a, hero_b|
        if hero_a[status_name_symbol] == hero_b[status_name_symbol]
          hero_a[:name] <=> hero_b[:name]
          #hero_b[:name] <=> hero_a[:name]
        else
          case order
          when :asc
            hero_a[status_name_symbol] <=> hero_b[status_name_symbol]
          when :desc
            hero_b[status_name_symbol] <=> hero_a[status_name_symbol]
          end
        end
      end
      status_list
    end
  end
end
Vainglory.init
