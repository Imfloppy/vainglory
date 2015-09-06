lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

OUTPUT_YML_NAME = "vainglory_heroes.yml"
OUTPUT_YML_PATH = File.expand_path("../../data/#{OUTPUT_YML_NAME}", __FILE__)

require 'open-uri'
require 'nokogiri'
require 'yaml'

require 'vainglory/scrape/scrape_hero_from_official'

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
  heroes = Hash.new
  hero_urls.each do |key, value| 
    hero_url = root_url + 'hero/' + value
    hero = Vainglory::ScrapeHeroFromOfficial.new(hero_url)
    heroes.merge!(hero.to_hash(:status))
  end
  yaml = YAML.dump(heroes)
  File.open(OUTPUT_YML_PATH, 'w') do |file|
    file.print(yaml)
  end
end

main
