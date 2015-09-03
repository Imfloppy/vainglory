require 'vainglory'

puts Vainglory.heros.sort_by { |_, h| h.name }
hero = Vainglory.hero :koshka
puts hero.name
# puts Vainglory.heros.max_by{ |_, h| h.hp}.name