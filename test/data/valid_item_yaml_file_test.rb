require 'test_helper'

require 'yaml'

describe 'yaml file about item' do
  ITEMS_NUMBER = 61
  MAX_TIER = 3
  ITEM_YAML = YAML.load_file('./data/item.yml')
  ALL_KEYS = get_all_hash_keys(ITEM_YAML)

  describe 'number of items' do
    it "is #{ITEMS_NUMBER}" do
      ITEM_YAML.size.must_equal(ITEMS_NUMBER)
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

  describe 'all item' do
    it 'has kind' do
      ITEM_YAML.each_value do |item|
        item.key?(:kind).must_equal(true)
      end
    end
    it 'has buy' do
      ITEM_YAML.each_value do |item|
        item.key?(:buy).must_equal(true)
      end
    end
  end

  describe 'expect consumable item' do
    EXPECT_CONSUMABLE_ITEM = ITEM_YAML.select do |name, value|
      !value[:kind].include?("consumable")
    end

    it 'has tier' do
      EXPECT_CONSUMABLE_ITEM.each_value do |item|
        item.key?(:tier).must_equal(true, item)
      end
    end

    it 'has a same kind as upgrade item' do
      EXPECT_CONSUMABLE_ITEM.each do |from_name, from_item|
        next if from_item[:tier] == MAX_TIER
        has_same_kind = false
        # アップグレード先のアイテムと階層1以外のアイテム一覧を比較
        EXPECT_CONSUMABLE_ITEM.each do |exist_name, exist_item|
          if exist_item[:tier] != 1 && from_item[:to].include?(exist_name.to_s)
            has_same_kind = true
            break
          end
        end
        has_same_kind.must_equal(true, from_name)
      end
    end

    describe 'expect tier 3 item' do
      it 'has upgrade item exists'
    end

    describe 'expect tier 1 item' do
      it 'exists on other upgrade root'
    end
  end

  describe 'only consumable item' do
    it 'has no tier'do
      ITEM_YAML.each_value do |item|
        if item[:kind] == 'consumable'
          item.key?(:tier).must_equal(false)
        end
      end
    end
  end
end
