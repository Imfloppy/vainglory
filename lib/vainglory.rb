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
      self.heroes.each do |hero_name, hero_value|
        heroes_ability[hero_name].each do |ability_name, ability_status|
          ability = { name: ability_name.to_s }
          # パッシブアビリティがまだ未入力のためnilか確認
          ability.merge!(ability_status) if !ability_status.nil?
          hero_value.ability << ability
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

    def ability(status_name, order = :desc)
      ability_list = []
      status_name_symbol = status_name.to_sym
      self.heroes.each_value do |hero|
        hero.ability[1..3].each do |ability|
          next if ability[status_name_symbol].nil?
          ability_status = ability[status_name_symbol][:effect]
          case ability_status
          when Array
            ability_status.each_index do |i|
              ability_hash = {}
              ability_hash[:name] = ability[:name]
              ability_hash[:level] = i + 1
              ability_hash[status_name_symbol] = ability_status[i]
              ability_list << ability_hash
            end
          else
            ability_hash = {}
            ability_hash[:name] = ability[:name]
            ability_hash[status_name_symbol] = ability_status
            ability_list << ability_hash
          end
        end
      end

      ability_list.sort! do |ability_a, ability_b|
        if ability_a[status_name_symbol] == ability_b[status_name_symbol]
          ability_a[:name] <=> ability_b[:name]
        else
          case order
          when :asc
            ability_a[status_name_symbol] <=> ability_b[status_name_symbol]
          when :desc
            ability_b[status_name_symbol] <=> ability_a[status_name_symbol]
          end
        end
      end
      ability_list
    end
  end
end
Vainglory.init
