# coding: utf-8
require 'sinatra'
require 'sinatra/reloader'
require 'faraday'
require 'pp'
require 'json'

client_id = '1QYVILBI0BBHU0KAVLS3QG3XVJS4RAZXVP1JQRC3TIOPMR2W'
client_secret = 'K2PNFG23NKIMWBUIMYEHHF5ZWHCXIESPCZB0G4TZPA2IAINZ'

http_client = Faraday.new(:url => 'https://api.foursquare.com')

get '/' do
  erb :index
end

get '/going' do
  art = http_client.get('/v2/venues/search?ll=36.643,138.188686&client_id=' + client_id + '&client_secret=' + client_secret + '&v=20121222&radius=3500&categoryId=4d4b7104d754a06370d81259')
  art = JSON.parse(art.body.force_encoding('UTF-8'))['response']['venues']
  food = http_client.get('/v2/venues/search?ll=36.643,138.188686&client_id=' + client_id + '&client_secret=' + client_secret + '&v=20121222&radius=3500&categoryId=4d4b7105d754a06374d81259')
  food = JSON.parse(food.body.force_encoding('UTF-8'))['response']['venues']
  shop = http_client.get('/v2/venues/search?ll=36.643,138.188686&client_id=' + client_id + '&client_secret=' + client_secret + '&v=20121222&radius=3500&categoryId=4d4b7105d754a06378d81259')
  shop = JSON.parse(shop.body.force_encoding('UTF-8'))['response']['venues']
  all_places = art.concat(food)
  all_places = all_places.concat(shop)

  all_places = all_places.select do |place|
    36.643 < place['location']['lat'] && place['location']['lat'] < 36.664 && 138.1738187 < place['location']['lng'] && place['location']['lng'] < 138.187
  end
  all_places = all_places.sort_by do |place|
    place['location']['lat']
  end
  all_places.each do |place|
    pp place['location']['lat']
  end
  tmp = (0..all_places.count()).to_a.sample(3).sort!
  @places = [all_places[tmp[0]], all_places[tmp[1]], all_places[tmp[2]]]

  erb :going
end

get '/return' do
  art = http_client.get('/v2/venues/search?ll=36.643,138.188686&client_id=' + client_id + '&client_secret=' + client_secret + '&v=20121222&radius=3500&categoryId=4d4b7104d754a06370d81259')
  art = JSON.parse(art.body.force_encoding('UTF-8'))['response']['venues']
  food = http_client.get('/v2/venues/search?ll=36.643,138.188686&client_id=' + client_id + '&client_secret=' + client_secret + '&v=20121222&radius=3500&categoryId=4d4b7105d754a06374d81259')
  food = JSON.parse(food.body.force_encoding('UTF-8'))['response']['venues']
  shop = http_client.get('/v2/venues/search?ll=36.643,138.188686&client_id=' + client_id + '&client_secret=' + client_secret + '&v=20121222&radius=3500&categoryId=4d4b7105d754a06378d81259')
  shop = JSON.parse(shop.body.force_encoding('UTF-8'))['response']['venues']
  all_places = art.concat(food)
  all_places = all_places.concat(shop)

  all_places = all_places.select do |place|
    36.643 < place['location']['lat'] && place['location']['lat'] < 36.664 && 138.188 < place['location']['lng'] && place['location']['lng'] < 138.198
  end
  all_places = all_places.sort_by do |place|
    place['location']['lat']
  end
  all_places.each do |place|
    pp place['location']['lat']
  end
  tmp = (0..all_places.count()).to_a.sample(3).sort!{|a, b| b <=> a}
  @places = [all_places[tmp[0]], all_places[tmp[1]], all_places[tmp[2]]]

  erb :return
end
