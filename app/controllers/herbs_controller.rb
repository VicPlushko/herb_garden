class HerbsController < ApplicationController

    get '/herbs' do
        @herbs = Herb.all
        erb :'herbs/index'
      end

      get '/herbs/new' do
        erb :'herbs/new'
      end

      post '/herbs' do
        herb = Herb.new(
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
          considerations: params[:considerations]
          )
          if herb.save
            redirect "/herbs/#{herb.id}"
          else
            redirect '/herbs/new'
          end
      end

      get '/herbs/:id' do
        @herb = Herb.find_by_id(params[:id])

        if @herb
            erb :'/herbs/show'
        else
            redirect '/herbs'
        end
      end

      get '/herbs/:id/edit' do
        @herb = Herb.find_by_id(params[:id])
        erb :'/herbs/edit'
      end

      patch '/herbs/:id' do
        herb = Herb.find_by_id(params[:id])
        
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
          considerations: params[:considerations]
          )
          redirect "/herbs/#{herb.id}"
        else
          redirect "/herbs/#{herb.id}/edit"
        end
      end

      delete '/herbs/:id' do
        herbs = Herb.find_by_id(params[:id])
        if herb
          herb.delete
        end
        redirect '/herbs'
      end


end