class HerbsController < ApplicationController

    get '/herbs' do
        @herbs = Herb.all
        erb :'herbs/index'
      end

      get '/herbs/new' do
        erb :'herbs/new'
      end

      post '/herbs' do
      end

      get '/herbs/:id' do
        @herb = Herb.find_by_id(params[:id])

        if @herb
            erb :'/herbs/show'
        else
            redirect '/herbs'
        end
      end
end