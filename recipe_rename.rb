require 'open-uri'
require 'net/http'
require 'json'
#puts File.exist?("hero_images/abaddon_hphover.png")
key = #<key>
link = "http://api.steampowered.com/IEconDOTA2_570/GetGameItems/V001/?key=#{key}"
item_ids = open(link)
ids = item_ids.read
my_hash = JSON.parse(ids)
i = 0
my_hash['result']['items'].each {|item|
  name = item['name'].to_s
  if !name.include?('recipe')
    next
  end
  id = item['id'].to_s
  File.rename("#{i.to_s}.png", "#{id}.png")
  i += 1
  puts name , id
}
