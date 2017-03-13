require 'open-uri'
require 'net/http'
require 'json'
require 'pg'

conn = PG.connect(dbname: dbname , password: password)
tournament = File.read("db/boston_major_games.json")
games = JSON.parse(tournament)
games["result"]["matches"].each do |game|
  id = game["match_id"]
  key = #key
  link = "http://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/v1/?key=#{key}&match_id=#{id}"
  data_dump = open(link)
  match = data_dump.read
  data = JSON.parse(match)
  match_id = data["result"]["match_id"].to_i
  radiant_name = data["result"]["radiant_name"].to_s
  dire_name = data["result"]["dire_name"].to_s
  radiant_win = data["result"]["radiant_win"]
  leagueid = data["result"]["leagueid"]

  match_ids = conn.exec("SELECT match_id FROM player_stats WHERE match_id = #{match_id}").values
  match_ids.flatten!

  if match_ids.size == 0
    data["result"]["players"].each do |player|
      if player["player_slot"] & 128 == 128
        team = dire_name
        side = "dire"
        win = !radiant_win
        #set win value and side and name here
      else
        team = radiant_name
        side = "radiant"
        win = radiant_win
      end
      account_id = player["account_id"].to_i
      hero_id = player["hero_id"].to_i
      item_0 = player["item_0"].to_i
      item_1 = player["item_1"].to_i
      item_2 = player["item_2"].to_i
      item_3 = player["item_3"].to_i
      item_4 = player["item_4"].to_i
      item_5 = player["item_5"].to_i
      backpack_0 = player["backpack_0"].to_i
      backpack_1 = player["backpack_1"].to_i
      backpack_2 = player["backpack_2"].to_i
      kills = player["kills"].to_i
      deaths = player["deaths"].to_i
      assists = player["assists"].to_i
      last_hits = player["last_hits"].to_i
      denies = player["denies"].to_i
      gold_per_min = player["gold_per_min"].to_i
      xp_per_min = player["xp_per_min"].to_i
      level = player["level"].to_i
      hero_damage = player["hero_damage"].to_i
      tower_damage = player["tower_damage"].to_i
      hero_healing = player["hero_healing"].to_i
      gold = player["gold"].to_i
      gold_spent = player["gold_spent"].to_i

      conn.exec("INSERT INTO player_stats VALUES(#{account_id},\'#{side}\',\'#{team}\',#{hero_id},#{item_0},#{item_1},#{item_2},#{item_3},#{item_4},#{item_5},#{backpack_0},#{backpack_1},#{backpack_2},#{kills},#{deaths},#{assists},#{last_hits},#{denies},#{gold_per_min},#{xp_per_min},#{level},#{hero_damage},#{tower_damage},#{hero_healing},#{gold},#{gold_spent},#{win},#{leagueid},#{match_id})" )
    end
  end
end
