module Vainglory
  class Hero
    attr_reader :name
    def initialize(name, options = nil)
      @name = name
    end
  end
end
