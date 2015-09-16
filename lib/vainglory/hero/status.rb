module Vainglory
  class Hero
    module Status
      %w(hp hp_regen ep ep_regen weapon_damage attack_speed
         armor shield attack_range move_speed).each do |action|
        define_method(action) do
          update(@status[action.to_sym][:start],
                 @level,
                 @status[action.to_sym][:glow])
        end
      end

      private

      def update(start, level, glow)
        if glow.is_a?(Numeric)
          start + (level - 1) * glow
        else
          start
        end
      end
    end
  end
end
