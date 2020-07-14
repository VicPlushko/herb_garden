require "./config/environment"
require "sinatra/base"
require "sinatra/flash"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, ENV.fetch("GARDEN_SECRET")
    register Sinatra::Flash
  end

  get "/" do
    erb :index
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user ||= User.find_by_id(session[:user_id]) if logged_in?
    end
  end

  def not_logged_in
    if !logged_in?
      redirect "/index"
    end
  end
end
