module Vainglory
  class Hero
    attr_reader :name, :level, :hp
    def initialize(name, options = {})
      @name = name
      options.each do |key, value|
        value.each do |k, v|
          instance_variable_set("@#{key.to_s}_#{k.to_s}", v)
        end
      end
      set_level(1)
    end

    def set_level(num)
      @level = num
      @hp = @hp_start + (num - 1) * @hp_glow
      self
    end
  end
end
