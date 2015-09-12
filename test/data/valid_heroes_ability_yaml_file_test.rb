require 'test_helper'

require 'yaml'

HEROES_NUMBER = 17
ABILITY_YAML = YAML.load_file('./data/heroes_ability.yml')
ALL_KEYS = get_all_hash_keys(ABILITY_YAML)

describe 'number of heroers' do
  it "is #{HEROES_NUMBER}" do
    ABILITY_YAML.size.must_equal(HEROES_NUMBER)
  end
end

describe 'all key name' do
  it 'has no spaces' do
    ALL_KEYS.each do |value|
      value.wont_match(/\s/)
    end
  end
  it 'has no exclamation mark' do
    ALL_KEYS.each do |value|
      value.wont_match(/!/)
    end
  end
  it 'has no question mark' do
    ALL_KEYS.each do |value|
      value.wont_match(/\?/)
    end
  end
  it 'has no comma' do
    ALL_KEYS.each do |value|
      value.wont_match(/,/)
    end
  end
  it 'starts with lower case' do
    ALL_KEYS.each do |value|
      value.must_match(/^[a-z]/)
    end
  end
end

describe 'value of weapon ratio' do
  it 'is persent string' do
    reg = /^\d+\.?\d*%$/
    values = get_all_hash_values_with_target_key(ABILITY_YAML, :weapon_ratio)
    values.each do |value|
      if value.is_a?(Hash)
        value[:effect].each { |v| v.must_match(reg) }
      else
        value.must_match(reg)
      end
    end
  end
end

describe 'value of crystal ratio' do
  it 'is persent' do
    reg = /^\d+\.?\d*%$/
    values = get_all_hash_values_with_target_key(ABILITY_YAML, :crystal_ratio)
    values.each do |value|
      if value.is_a?(Hash)
        value[:effect].each { |v| v.must_match(reg) }
      else
        value.must_match(reg)
      end
    end
  end
end

describe 'passive ability' do
  it 'is nil' do
    ABILITY_YAML.each_value do |abilities|
      abilities.values[0].must_be_nil
    end
  end
end

describe 'active ability' do
  it 'is not nil' do
    ABILITY_YAML.each_value do |abilities|
      abilities.values[1..3].each { |v| wont_be_nil }
    end
  end

  describe '1 and 2' do
    it 'has 5 values of effect'do
      ABILITY_YAML.each_value do |abilities|
        abilities.values[1..2].each do |items|
          items.each_value { |item| item[:effect].size.must_equal(5) }
        end
      end
    end
  end

  describe '3' do
    it 'has 3 values of effect' do
      ABILITY_YAML.each_value do |abilities|
        abilities.values[3].each_value do |item|
          item[:effect].size.must_equal(3)
        end
      end
    end
  end
end

describe 'each hero' do
  it 'has 4 abilities' do
    ABILITY_YAML.each_value do |abilities|
      abilities.size.must_equal(4)
    end
  end
end

describe 'each active ability' do
  it 'has cool down' do
    ABILITY_YAML.each_value do |abilities|
      abilities.values[1..3].each do |ability|
        ability.key?(:cool_down).must_equal(true, ability)
      end
    end
  end
  it 'has energy cost' do
    exclude_heros = [:rona, :ardan]
    ABILITY_YAML.each do |hero_name, abilities|
      if exclude_heros.include?(hero_name) then next end
      abilities.values[1..3].each do |ability|
        ability.key?(:energy_cost).must_equal(true, ability)
      end
    end
  end
end
