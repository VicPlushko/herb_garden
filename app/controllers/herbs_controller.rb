class HerbsController < ApplicationController
  get "/herbs" do
    not_logged_in
    @herbs = current_user.herbs.order("name ASC")
    erb :'herbs/index'
  end

  get "/herbs/new" do
    not_logged_in
    erb :'herbs/new'
  end

  post "/herbs" do
    not_logged_in
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
      flash[:created_herb] = "You have successfully created an herb."
      redirect "/herbs/#{herb.id}"
    else
      redirect "/herbs"
    end
  end

  get "/search" do
    not_logged_in
    erb :'/herbs/search'
  end

  get "/results" do
    not_logged_in
    @herbs = current_user.herbs.search(params[:search]).order("name ASC")
    flash[:search] = params[:search]
    if params[:search].blank?
      flash[:empty_search] = "Please enter a name, taste, energetic, action or what the herb is ideal for."
      redirect "/search"
    elsif params[:search].size < 3
      flash[:invalid_search] = "Search must be a minimum of 3 characters."
      redirect "/search"
    elsif @herbs.size > 0
      erb :'herbs/results'
    else
      flash[:search_fail] = "There are no herbs that match your search. Please try again."
      redirect "/search"
    end
  end

  get "/herbs/:id" do
    not_logged_in
    @herb = current_user.herbs.find_by_id(params[:id])
    if @herb
      erb :'/herbs/show'
    else
      redirect "/herbs"
    end
  end

  get "/herbs/:id/edit" do
    not_logged_in
    @herb = current_user.herbs.find_by_id(params[:id])
    if @herb
      erb :'/herbs/edit'
    else
      redirect "/herbs"
    end
  end

  patch "/herbs/:id" do
    not_logged_in
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
  end

  delete "/herbs/:id" do
    not_logged_in
    herb = current_user.herbs.find_by_id(params[:id])
    if herb
      herb.delete
    end
    redirect "/herbs"
  end
end
