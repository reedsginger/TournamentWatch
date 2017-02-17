require 'open-uri'
require 'net/http'
require 'json'
key = #<key>
link = "http://api.steampowered.com/IEconDOTA2_570/GetHeroes/V001/?key=#{key}"
hero_ids = open(link)
ids = hero_ids.read
my_hash = JSON.parse(ids)

my_hash['result']['heroes'].each {|hero|
  name = hero['name'].to_s
  name.gsub!("npc_dota_hero_", '')
  id = hero['id'].to_s
  File.rename("hero_images/#{name}_hphover.png", "hero_images/#{id}_hphover.png")
  File.rename("hero_images/#{name}_sb.png", "hero_images/#{id}_sb.png")
  puts name , id
}
