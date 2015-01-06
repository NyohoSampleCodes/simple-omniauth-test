require './app.rb'
require 'rack/static'
require 'omniauth'
require 'omniauth-twitter'
require 'dotenv'
require 'dalli'
require 'rack/session/dalli'

Dotenv.load

use Rack::Session::Dalli, expire_after: 60 * 60 * 24 * 30 - 1, memcache_server: '0.0.0.0:11211'
use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end

map "/public" do
  run Rack::File.new("public/")
end

run MyApp.new
