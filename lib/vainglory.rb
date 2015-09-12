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

      status_list.sort_by! do |hero|
        hero[status_name_symbol]
      end
      case order
      when :asc
        status_list
      when :desc
        status_list.reverse
      end
    end
  end
end
Vainglory.init
