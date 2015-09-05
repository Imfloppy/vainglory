module Vainglory
  class Ability
    def initialize(name, effect)
      @name = name
      @effect = effect
    end

    attr_accessor :name, :effect

    def to_hash
      hash = Hash.new
      hash.store(@name.to_sym, @effect)
      hash
    end
  end
end
