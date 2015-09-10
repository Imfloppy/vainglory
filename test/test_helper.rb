$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift File.expand_path('../../data', __FILE__)
require 'vainglory'

require 'minitest/autorun'
require 'awesome_print'

def get_all_hash_keys(hash)
  all_keys = []
  case hash
  when Hash
    hash.each do |k, v|
      all_keys << k
      all_keys.concat get_all_hash_keys(v)
    end
  when Array
    hash.each do |v|
      all_keys.concat get_all_hash_keys(v)
    end
  end
  all_keys
end

def get_all_hash_values_with_target_key(hash, target_key)
  all_values = []
  case hash
  when Hash
    hash.each do |k, v|
      all_values << v if k == target_key
      all_values.concat get_all_hash_values_with_target_key(v, target_key)
    end
  when Array
    hash.each do |v|
      all_values.concat get_all_hash_values_with_target_key(v, target_key)
    end
  end
  all_values
end
