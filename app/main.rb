require 'pry'
require 'active_record'
require 'sinatra'
require 'sinatra/reloader'

require_relative './functions'

class Blog < Sinatra::Base
  get "/" do
    erb :home
  end
  
  post "/log_in" do
    user = User.find_by_username(params[:username])
    
    if user && user.password == params[:password]
      params[:id] = user.id
      redirect to("/blog/#{params[:id]}")
    else
      redirect to("/")
    end
  end
  
  post "/sign_up" do
    # Checks to see if that username is already taken
    user = User.find_by_username(params[:username])
    
    # Redirects the user back to the homepage if the username is taken.
    # Creates the new user if username is not taken and redirects to blog page.
    if user
      redirect to("/")
    else
      user = User.create({
        :username => params[:username],
        :password => params[:password],
        :first_name => params[:first_name],
        :last_name => params[:last_name],
        :email => params[:email]
      })
    
      params[:id] = user.id
    
      redirect to("/blog/#{params[:id]}")
    end
  end
  
  get "/blog/:id" do
    @user = User.find(params[:id])
    
    erb :blog
  end
  
  get "/blog/new_post/:id" do
    @user = User.find(params[:id])
    
    erb :post
  end
  
  post "/blog/publish_post/:id" do
    @user = User.find(params[:id])
    
    new_post = Post.create({
      :user_id => @user.id,
      :title => params[:title],
      :content => params[:content]
    })
    
    redirect to ("/blog/#{params[:id]}")
  end
end