class UsersController < ApplicationController
    get '/signup' do
        if !logged_in?
            erb :'users/new'
        else
            redirect '/herbs'
        end
    end

    post '/signup' do
        if params[:name] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/signup'
        else
            user = User.new(name: params[:name], email: params[:email], password: params[:password])
            if user.save
                session[:user_id] = user.id
                redirect '/herbs'
            end
        end
    end
end