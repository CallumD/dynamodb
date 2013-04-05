require 'rspec'

describe "hashable should exist" do
  it "doesnt raise when called" do
     expect {
        Hashable
     }.to_not raise_error(NameError)
  end
end
