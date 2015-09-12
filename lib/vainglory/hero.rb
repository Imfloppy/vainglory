require 'vainglory/hero/status'

module Vainglory
  class Hero
    include Vainglory::Hero::Status
    attr_reader :name
    attr_accessor :level
    def initialize(name, options = {})
      @name = name
      @level = 1
      @status = options
    end
  end
end
