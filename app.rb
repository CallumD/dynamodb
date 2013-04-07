require 'sinatra/base'

module DynamoDB
  class App < Sinatra::Base
    require './message'

    get '/' do
      Message.find('1').text
    end

  end
end
