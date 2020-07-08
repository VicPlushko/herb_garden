class SessionsController < ApplicationController
    get "/login" do
    erb :'sessions/login'
  end

  post "/login" do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/herbs"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/about' do
    if logged_in?
      erb :'sessions/about'
    end
  end

  get '/contact' do
    if logged_in?
      erb :'sessions/contact'
    end
  end
end
