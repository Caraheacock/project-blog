require 'spec_helper'

describe "Blog" do
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
    
    @post1 = @caraisakitty.posts.create({
      :user_id => @caraisakitty.id,
      :title => "Tra la la la la",
      :content => "Look, I created a post! It is the most amazing of posts."
    })
    
    @comment1 = @post1.comments.create({
      :post_id => @post1.id,
      :commenter => "Bob",
      :email => "bob@bob.com",
      :content => "Great post!"
    })
  end
  
  # User class tests
  it "creates a user" do
    expect(@caraisakitty.username).to eq("CaraisaKitty")
  end
  
  it "allows updates to user information" do
    @caraisakitty.update_attributes({:password => "meow"})
    expect(@caraisakitty.password).to eq("meow")
  end
  
  # Post class tests
  it "creates a post" do
    expect(@post1.title).to eq("Tra la la la la")
  end
  
  it "creates a post associated with a particular user" do
    expect(@post1.user_id).to eq(@caraisakitty.id)
  end
  
  it "allows edits to a post" do
    @post1.update_attributes({:title => "Oh noes"})
    expect(@post1.title).to eq("Oh noes")
  end
  
  it "allows deletion of posts" do
    post2 = @caraisakitty.posts.create({
      :user_id => @caraisakitty.id,
      :title => "My biggest secret",
      :content => "Cara is secretly a cat in a person suit. This can never be publicly posted anywhere."
    })
    Post.delete(post2.id)
    post2 = @caraisakitty.posts[post2.id]
    expect(post2).to eq(nil)
  end
  
  # Comment class tests
  it "creates a comment" do
    expect(@comment1.commenter).to eq("Bob")
  end
  
  it "creates a comment associated with a particular post" do
    expect(@comment1.post_id).to eq(@post1.id)
  end
  
  it "allows edits to a comment" do
    @comment1.update_attributes({:commenter => "Joe"})
    expect(@comment1.commenter).to eq("Joe")
  end
  
  it "allows deletion of comments" do
    comment2 = @post1.comments.create({
      :post_id => @post1.id,
      :commenter => "Mary",
      :email => "mary@mary.com",
      :content => "You suck!"
    })
    Comment.delete(comment2.id)
    comment2 = @post1.comments[comment2.id]
    expect(comment2).to eq(nil)
  end 
end