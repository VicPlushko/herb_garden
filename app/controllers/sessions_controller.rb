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
      flash[:alert] = "Your email or password do not match. Please try again."
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/about' do
    not_logged_in
      erb :'sessions/about'
  end

  get '/contact' do
    not_logged_in
      erb :'sessions/contact'
  end
end
