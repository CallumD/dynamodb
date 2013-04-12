require 'sinatra/base'
require './message'

module Dyntest
  class App < Sinatra::Base

    get '/' do
    end 

    get '/messages' do
      "#{Message.all.map(&:to_h)}"
    end

    get '/messages/:id' do
      "#{Message.find(params[:id].to_s()).to_h}"
    end
   
    post '/messages/' do
      Message.new(params[:message]).save
      "Message saved"
    end

    put '/messages/:id' do
      Message.new(params[:message]).save
      "Message edited"
    end
 
    delete '/messages/:id' do 
      Message.find(params[:id].to_s).delete
      "Message deleted"
    end
  end
end
