require './app.rb'
require 'rack/static'
require 'omniauth'
require 'omniauth-twitter'
require 'dotenv'

Dotenv.load

use Rack::Session::Cookie, secret: 'sakurasaku'
use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end

map "/public" do
  run Rack::File.new("public/")
end

run MyApp.new
