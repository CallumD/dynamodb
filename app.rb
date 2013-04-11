require 'sinatra/base'
require './message'

module Dyntest
  class App < Sinatra::Base

    get '/' do
      table = DynamoDB::DynamoDB.tables['Message']
      table.load_schema
      "#{table.items.inject([]) { |res, item| res << item.attributes.to_h }}" end 
    get 'messages/' do
      Message.find('1')
    end

    get 'messages/:id' do
      Message.find(params[:id])
    end
  end
end
