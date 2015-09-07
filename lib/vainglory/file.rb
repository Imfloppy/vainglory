require 'yaml'

module Vainglory
  module File
    class << self
      def load_data(filename)
        YAML.load_file(
          ::File.expand_path("data/#{filename}")
        )
      end
    end
  end
end
