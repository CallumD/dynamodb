require 'sinatra/base'

module DynamoDB
  class App < Sinatra::Base
    require './message'

    get '/' do
    end

    get 'messages/' do
      Message.find('1')
    end

    get 'messages/:id' do
      Message.find(params[:id])
    end
  end
end
