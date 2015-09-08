require 'vainglory/scrape/ability'
require 'vainglory/scrape/status'

module Vainglory
  class ScrapeHeroFromOfficial
    def initialize(url)
      charset = nil
      html = open(url) do |f|
        charset = f.charset
        f.read
      end
      @doc = Nokogiri::HTML.parse(html, nil, charset)
      get_hero_name
      get_excerpt
      get_status
      get_ability
    end

    attr_accessor :doc, :name, :statuses, :excerpt, :abilities

    def get_hero_name
      @name = @doc.xpath("//div[@class='md-show']/h1").text
    end

    def get_excerpt
      @excerpt = @doc.css('p.excerpt').text
    end

    def get_status
      status_array = []
      # h6とh4の子孫要素を持つdivを取得
      @doc.xpath("//div[@id='stats-wrapper']//div[h6 and h4]").each do |status_div|
        status_name = status_div.css('h6').text
        status_str = status_div.css('h4').text.strip
        status_start = get_float_from_match(status_str.match(/\d+(?:.\d+)?/))
        status_glow = get_float_from_match(status_str.match(/\((\+\d+(?:\.\d+)?)\)/))
        status = Vainglory::Status.new(status_name, status_start, status_glow)

        status_array.push(status)
      end
      @statuses = status_array
    end

    def get_ability
      ability_array = []
      @doc.css('div.ability').xpath("./div[@class='text' and p[@class='mb0 md-show']]").each do |ability_div|
        ability_name = ability_div.css('h5.white').text
        ability_effect = ability_div.css('p.mb0').text
        ability = Vainglory::Ability.new(ability_name, ability_effect)

        ability_array.push(ability)
      end
      @abilities = ability_array
    end

    def to_hash(format=nil)
       status_hash = Hash.new
       @statuses.each do |status|
         status_hash.merge!(status.to_hash)
       end

       ability_hash = Hash.new
       @abilities.each do |ability|
         ability_hash.merge!(ability.to_hash)
       end

       case format
       when nil
         {
           name: @name,
           excerpt: @excerpt,
           status: status_hash,
           ability: ability_hash
         }
       when :status
         hash = Hash.new
         hash.store(@name.to_sym, status_hash)
         hash
       end
    end

    private
      # キャプチャを1つ使っていた場合は、キャプチャ部分を数値に変換する
      # キャプチャを使っていない場合は、マッチした部分を数値に変換する
      # キャプチャを2つ以上使うケースはnilを返す
      def get_float_from_match(match_data)
        # TODO NaNの対応
        if match_data
          if match_data[1]
            match_data[1].to_f
          else
            match_data[0].to_f
          end
        else
          nil
        end
      end
  end
end
