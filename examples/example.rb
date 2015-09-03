require 'vainglory'

puts Vainglory.heroes.sort_by { |_, h| h.name }
hero = Vainglory.hero :koshka
puts hero.name
# puts Vainglory.heroes.max_by{ |_, h| h.hp}.name