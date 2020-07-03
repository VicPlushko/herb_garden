class HerbsController < ApplicationController
  get "/herbs" do
    if logged_in?
      @herbs = current_user.herbs
      erb :'herbs/index'
    else
      redirect "/login"
    end
  end

  get "/herbs/new" do
    if logged_in?
      erb :'herbs/new'
    else
      redirect "/login"
    end
  end

  post "/herbs" do
    if logged_in?
      herb = current_user.herbs.build(
        name: params[:name],
        latin_name: params[:latin_name],
        family: params[:family],
        medicinal_parts: params[:medicinal_parts],
        taste: params[:taste],
        energetics: params[:energetics],
        actions: params[:actions],
        ideal_for: params[:ideal_for],
        applications: params[:applications],
        dosage: params[:dosage],
        considerations: params[:considerations],
      )
      if herb.save
        redirect "/herbs/#{herb.id}"
      else
        redirect "/herbs/new"
      end
    else
      redirect "/login"
    end
  end

  get '/search' do
    if logged_in?
      erb :'/herbs/search'
    else
      redirect '/login'
    end
  end

  get '/results' do
    if logged_in?
      @herbs = Herb.search(params[:search])
      erb :'herbs/results'
    else
      redirect '/search'
    end
  end

  get "/herbs/:id" do
    if logged_in?
      @herb = current_user.herbs.find_by_id(params[:id])
      if @herb
        erb :'/herbs/show'
      else
        redirect "/herbs"
      end
    else
      redirect "/login"
    end
  end

  get "/herbs/:id/edit" do
    if logged_in?
      @herb = current_user.herbs.find_by_id(params[:id])
      if @herb
        erb :'/herbs/edit'
      else
        redirect "/herbs"
      end
    else
      redirect "/login"
    end
  end

  patch "/herbs/:id" do
    if logged_in?
      herb = current_user.herbs.find_by_id(params[:id])
      if herb
        if herb.update(
          name: params[:name],
          latin_name: params[:latin_name],
          family: params[:family],
          medicinal_parts: params[:medicinal_parts],
          taste: params[:taste],
          energetics: params[:energetics],
          actions: params[:actions],
          ideal_for: params[:ideal_for],
          applications: params[:applications],
          dosage: params[:dosage],
          considerations: params[:considerations],
        )
          redirect "/herbs/#{herb.id}"
        else
          redirect "/herbs/#{herb.id}/edit"
        end
      else
        redirect "/herbs/#{herb.id}/edit"
      end
    else
      redirect "/login"
    end
  end

  delete "/herbs/:id" do
    if logged_in?
      herb = Herb.find_by_id(params[:id])
      if herb
        herb.delete
      end
      redirect "/herbs"
    else
      redirect "/login"
    end
  end
end
