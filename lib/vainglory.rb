require 'vainglory/version'
require 'vainglory/hero'

module Vainglory
  class HeroNameError < StandardError; end

  class << self
    attr_accessor :heros

    def hero(name = nil)
      @heros.fetch(name)
    rescue KeyError
      raise HeroNameError, 'Invalid hero name'
    end
  end
end

Vainglory.heros = {
  "koshka": Vainglory::Hero.new('koshka'),
  "joule": Vainglory::Hero.new('joule')
}
