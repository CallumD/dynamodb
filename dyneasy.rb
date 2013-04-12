module Dyneasy
  require 'securerandom'
  require './hashable'
  require './dynamodb'

  include Dyneasy::Hashable

  def self.included(base)
    @@table = DynamoDB::DynamoDB.tables[base.to_s]
    base.class_eval do
      attr_accessor @@table.hash_key.name.to_sym
      attr_accessor :updated_at
      attr_accessor :created_at
      def self.all
        @@table.items.inject([]) { |res, item| res << self.new(item.attributes.to_h) }
      end

      def self.find(id)
        hash_found = @@table.items[id].attributes.to_h
        found = self.new(hash_found)
        found.send("#{@@table.hash_key.name}=", hash_found[@@table.hash_key.name]) 
        found
      end
     
      def self.query(&block)
       x = yield @@table.items 
       x.map{ |item| self.new(item.attributes.to_h) }
      end
    end
  end

  def delete
    @@table.items[self.send(@@table.hash_key.name)].delete
  end

  def save
    key = @@table.hash_key.name
    self.send("#{key}=", SecureRandom.uuid()) unless self.send(key)
    self.send("updated_at=", Time.now.utc.to_s)
    self.send("created_at=", Time.now.utc.to_s) unless self.send(:created_at)
    @@table.items.put(self.to_h)
  end
end

