require 'open-uri'
require 'net/http'
require 'json'
#puts File.exist?("hero_images/abaddon_hphover.png")
key = #<>
link = "http://api.steampowered.com/IEconDOTA2_570/GetGameItems/V001/?key=#{key}"
item_ids = open(link)
ids = item_ids.read
my_hash = JSON.parse(ids)

my_hash['result']['items'].each {|item|
  name = item['name'].to_s
  if !name.include?('recipe')
    name.gsub!("item_", '')
  else next
  end
  id = item['id'].to_s
  if File.exist?("item_images/#{name}_lg.png")
    File.rename("item_images/#{name}_lg.png", "item_images/#{id}.png")
  end
  puts name , id
}
