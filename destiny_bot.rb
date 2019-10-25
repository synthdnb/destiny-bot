require 'discordrb'
require 'oj'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

en_data = Oj.load_file('./data/en.json');
ko_data = Oj.load_file('./data/ko.json');
data = en_data + ko_data


bot = Discordrb::Bot.new token: ENV['TOKEN'], client_id: ENV['CLIENT_ID']


bot.message(contains: /\[\[([^:]+)\]\]/) do |event|
  event.message.content =~ /\[\[([^:]+)\]\]/
  q = $1
  next if q.length < 2
  
  filtered = data.select{|x| x["name"] =~ /#{q}/i}.sort_by{|x| [-x["tierType"], -x["index"]]}

  if f = filtered.first
    event.channel.send_embed do |embed|
      embed.title = "#{f["name"]} [#{f["typeAndTierName"]}]"
      embed.description = f["desc"]
      embed.url = "https://www.light.gg/db/ko/items/#{f["hash"]}"
      embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "https://www.bungie.net/#{f["icon"]}")
    end
  end
end

bot.run

