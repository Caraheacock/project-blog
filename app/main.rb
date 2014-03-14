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
    @user = User.find(params[:id])
    binding.pry
    
    "Hi, #{@user.first_name}!"
  end
end