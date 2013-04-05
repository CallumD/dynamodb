module Dyneasy
  require 'securerandom'
  require './hashable'

  include Dyneasy::Hashable

  def self.included(base)
    @@table = ::DynamoDB::DynamoDB.tables[base.to_s]
    base.class_eval do
      attr_accessor @@table.hash_key.name.to_sym
      def self.find(id)
        hash_found = @@table.items[id].attributes.to_h
        found = self.new(hash_found)
        found.send("#{@@table.hash_key.name}=", hash_found[@@table.hash_key.name]) 
        found
      end
    end
  end

  def delete
    @@table.items[self.send(@@table.hash_key.name)].delete
  end

  def save
    key = @@table.hash_key.name
    self.send("#{key}=", SecureRandom.uuid()) unless self.send(key)
    @@table.items.put(self.to_h)
  end
end

