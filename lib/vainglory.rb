require 'vainglory/version'
require 'vainglory/hero'

module Vainglory
  class HeroNameError < StandardError; end

  class << self
    attr_accessor :heroes

    def hero(name = nil)
      @heroes.fetch(name)
    rescue KeyError
      raise HeroNameError, 'Invalid hero name'
    end
  end
end

Vainglory.heroes = {
  "koshka": Vainglory::Hero.new('koshka'),
  "joule": Vainglory::Hero.new('joule')
}
