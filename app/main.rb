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
  
  get "/blog/:id" do
    
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
    
    erb :blog
  end
end