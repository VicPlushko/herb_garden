class SessionsController < ApplicationController
    get '/signup' do
        if !logged_in?
            erb :'users/new'
        else
            redirect '/herbs'
        end
    end

    post 'signup' do
        if params[:name] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/signup'
        else
            user = User.build(name: params[:name], email: params[:email], password: params[:password])
            if user.save
                session[:user_id] = user.
                redirect '/herbs'
            end
        end
    end
  
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
    redirect '/login'
  end
end
