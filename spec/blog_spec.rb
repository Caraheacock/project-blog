require 'spec_helper'

describe User do
  before(:all) do
    @caraisakitty = User.create({
      :username => "CaraisaKitty",
      :password => "omg",
      :first_name => "Cara",
      :last_name => "Heacock",
      :email => "caraheacock@gmail.com",
      :facebook => "https://www.facebook.com/cara.heacock",
      :twitter => "https://twitter.com/CaraHeacock"
    })
  end
  
  it "creates a user" do
    expect(@caraisakitty.username).to eq("CaraisaKitty")
  end
  
  it "allows updates to user information" do
    @caraisakitty.update_attributes({:password => "meow"})
    expect(@caraisakitty.password).to eq("meow")
  end
end