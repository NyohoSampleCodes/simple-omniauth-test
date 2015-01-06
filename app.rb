# Simple OmniAuth Test App

require 'sinatra'
require 'omniauth'

class MyApp < Sinatra::Base
  def user
    !session[:uid].nil?
  end

  def username
    session[:uid] if !session[:uid].nil?
  end
  
  get '/' do
    'Hi! ' + (session[:authenticated] ? 'Your ID: ' + username + ' / <a href="/logout">logout</a>' : '<a href="/auth/twitter">Sign in with Twitter</a>' )
  end

  get '/auth/twitter/callback' do
    session[:uid] = env['omniauth.auth'].uid
    session[:authenticated] = true
    redirect to('/')
  end

  get '/auth/failure' do
    'oh no! auth failure'
  end

 get '/logout' do
    session[:authenticated] = false
    redirect '/'
 end
end
