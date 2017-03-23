require 'open-uri'
require 'net/http'
require 'json'
require 'pg'

key = #key
link = "http://api.steampowered.com/IDOTA2Match_570/GetLiveLeagueGames/v1/?key=#{key}"
live_games = open(link)
games = live_games.read
gamedb = JSON.parse(games)
conn = PG.connect(dbname: '', password: ' ' )

gamedb['result']['games'].each do |game|
  game['players'].each do |player|
    if player['team'] == 0 || player['team'] == 1
      player_id = conn.exec("SELECT * FROM id_name WHERE account_id = #{player['account_id']}").values
      player_id.flatten!
      name = player['name']
      valid_name = name.gsub('\'', "\\\'")
      if player_id.size == 0
        conn.exec("INSERT INTO id_name VALUES(#{player['account_id']},\'#{valid_name}\')")
      end
    end
  end
end
