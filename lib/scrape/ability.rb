module Scrape
  class Ability
    attr_accessor :name, :effect

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
