class Message
require './dyneasy'

include Dyneasy
  attr_accessor :text

  def initialize(args = {})
    self.text = args["text"] || args[:text]
  end
end
