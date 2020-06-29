class HerbsController < ApplicationController

    get '/herbs' do
        @herbs = Herb.all
        erb :'herbs/index'
      end
end