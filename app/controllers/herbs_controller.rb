class HerbsController < ApplicationController
  get "/herbs" do
    if logged_in?
      @herbs = current_user.herbs.order('name ASC')
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
        flash[:notice] = "You have successfully created an herb."
        redirect "/herbs/#{herb.id}"
      else
        redirect '/herbs'
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
      @herbs = current_user.herbs.search(params[:search]).order('name ASC')
      if params[:search].blank?
          flash[:empty_search] = "Please enter a name, taste, energetic, action or what the herb is ideal for."
          redirect '/search'
      elsif params[:search].size < 3
        flash[:invalid_search] = "Search must be a minimum of 3 characters."
        redirect '/search'
      elsif @herbs.size > 0
        erb :'herbs/results'
      else
        flash[:search_fail] = "There are no herbs that match your search. Please try again."
        redirect '/search'
      end
    else
      redirect '/login'
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
          flash[:successful_update] = "You have successfully updated this herb"
          redirect "/herbs/#{herb.id}"
        else
          flash[:update_failure] = "The information did not update. Please make sure all fields are filled in."
          redirect "/herbs/#{herb.id}/edit"
        end
      else
        redirect "/herbs"
      end
    else
      redirect "/login"
    end
  end

  delete "/herbs/:id" do
    if logged_in?
      herb = current_user.herbs.find_by_id(params[:id])
      if herb
        herb.delete
      end
      redirect "/herbs"
    else
      redirect "/login"
    end
  end
end
