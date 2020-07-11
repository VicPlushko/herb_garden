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
            flash[:signup_fail] = "Please make sure you enter your name, a valid email address and create a password."
            redirect to '/signup'
        elsif User.is_email_valid?(params[:email])
            user = User.new(name: params[:name], email: params[:email], password: params[:password])
            if user.save
                session[:user_id] = user.id
                redirect '/herbs'
            else
                flash[:signup_fail] = "This email address is already in use."
                redirect '/signup'
            end
        else
            flash.now[:signup_fail] = "Please enter a valid email."
            redirect '/signup'
        end
    end
end