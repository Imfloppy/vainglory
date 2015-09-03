$LOAD_PATH.push('../lib')
require 'open-uri'
require 'nokogiri'
require 'yaml'

require 'scrape/status.rb'
require 'scrape/ability.rb'

module Scrape
  class HeroScrapeFromOfficial
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
      @excerpt = @doc.css("p.excerpt").text
    end

    def get_status
      status_array = []
      # h6とh4の子孫要素を持つdivを取得
      @doc.xpath("//div[@id='stats-wrapper']//div[h6 and h4]").each do |status_div|
        status = Status.new
        status.name = status_div.css("h6").text

        status_str = status_div.css("h4").text.strip
        status.start = get_float_from_match(status_str.match(/\d+(?:.\d+)?/))
        status.glow = get_float_from_match(status_str.match(/\((\+\d+(?:\.\d+)?)\)/))
        status_array.push(status)
      end
      @statuses = status_array
    end

    def get_ability
      ability_array = []
      @doc.css("div.ability").xpath("./div[@class='text' and p[@class='mb0 md-show']]").each do |ability_div|
        ability = Ability.new
        ability.name = ability_div.css("h5.white").text
        ability.effect = ability_div.css("p.mb0").text 
        ability_array.push(ability)
      end
      @abilities = ability_array
    end

    def to_hash
       status_array = []
       @statuses.each do |status|
         status_array.push(status.to_hash)
       end

       ability_array = []
       @abilities.each do |ability|
         ability_array.push(ability.to_hash)
       end

      {
        name: @name,
        #excerpt: @excerpt,
        status: status_array#,
        #ability: ability_array
      }
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

  def main
    root_url = 'http://jp.vainglorygame.com/'
    hero_urls = {
      rona: 'rona/',
      fortress: 'fortress/',
      joule: 'joule/',
      ardan: 'ardan/',
      skaarf: 'skaarf/',
      taka:'taka/',
      krul: 'krul/',
      saw: 'saw/',
      petal: 'petal/',
      glaive: 'glaive/',
      koshka: 'koshka/',
      adagio: 'adagio/',
      ringo: 'ringo/',
      chtherine: 'catherine/',
      celeste: 'celeste/',
      vox: 'vox/'
    }
    heroes = []
    hero_urls.each do |key, value| 
      hero_url = root_url + 'hero/' + value
      hero = HeroScrapeFromOfficial.new(hero_url)
      heroes.push(hero.to_hash)
    end
    yaml = YAML.dump(heroes)
    File.open('vainglory_heroes.yml', 'w') do |file|
      file.print(yaml)
    end
  end

  main
end
