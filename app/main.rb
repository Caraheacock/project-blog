require 'pry'
require 'active_record'
require 'sinatra'
require 'sinatra/reloader'

require_relative './functions'

class Blog < Sinatra::Base
  ####################
  # Main page routes #
  ####################
  get "/" do
    erb :home
  end
  
  post "/log_in" do
    user = User.find_by_username(params[:username])
    
    if user && user.password == params[:password]
      params[:id] = user.id
      redirect to("/blog/#{params[:username]}")
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
    
      redirect to("/blog/#{params[:username]}")
    end
  end
  
  ####################
  # Blog page routes #
  ####################
  
  get "/blog/:username" do
    @user = User.find_by_username(params[:username])
    
    erb :blog
  end
  
  get "/blog/:username/new_post" do
    @user = User.find_by_username(params[:username])
    
    erb :post
  end
  
  post "/blog/:username/publish_post" do
    @user = User.find_by_username(params[:username])
    
    new_post = Post.create({
      :user_id => @user.id,
      :title => params[:title],
      :content => params[:content]
    })
    
    redirect to("/blog/#{params[:username]}")
  end
  
  get "/blog/:username/:post_id" do
    @user = User.find_by_username(params[:username])
    @post = Post.find(params[:post_id])
    
    erb :read_post
  end
  
  ####################
  # Edit post routes #
  ####################
  
  get "/blog/:username/edit_post/:post_id" do
    @user = User.find_by_username(params[:username])
    @old_post = Post.find(params[:post_id])
    
    erb :post
  end
  
  post "/blog/:username/publish_post/:post_id" do
    @user = User.find_by_username(params[:username])
    old_post = Post.find(params[:post_id])
    
    old_post.update_attributes({
      :title => params[:title],
      :content => params[:content]
    })
    
    redirect to("/blog/#{params[:username]}")
  end
  
  ######################
  # Delete post routes #
  ######################
  
  get "/blog/:username/delete_confirm/:post_id" do
    @user = User.find_by_username(params[:username])
    @old_post = Post.find(params[:post_id])
    
    erb :delete
  end
  
  post "/blog/:username/delete_post/:post_id" do
    @user = User.find_by_username(params[:username])
    old_post = Post.find(params[:post_id])
    
    Post.delete(old_post.id)
    
    redirect to("/blog/#{params[:username]}")
  end
  
  ##################
  # Comment routes #
  ##################
  
  get "/blog/:username/:post_id/comment" do
    @user = User.find_by_username(params[:username])
    @post = Post.find(params[:post_id])
    
    erb :comment
  end
  
  post "/blog/:username/:post_id/publish_comment" do
    @user = User.find_by_username(params[:username])
    @post = Post.find(params[:post_id])
    
    comment = Comment.create({
      :post_id => @post.id,
      :commenter => params[:commenter],
      :email => params[:email],
      :content => params[:content]
    })
    
    redirect to("/blog/#{params[:username]}/#{params[:post_id]}#comment#{comment.id}")
  end
  
  #######################
  # Edit comment routes #
  #######################
  
  get "/blog/:username/:post_id/edit_comment/:comment_id" do
    @user = User.find_by_username(params[:username])
    @post = Post.find(params[:post_id])
    @old_comment = Comment.find(params[:comment_id])
    
    erb :comment
  end
  
  post "/blog/:username/:post_id/publish_comment/:comment_id" do
    @user = User.find_by_username(params[:username])
    @post = Post.find(params[:post_id])
    old_comment = Comment.find(params[:comment_id])
    
    old_comment.update_attributes({
      :commenter => params[:commenter],
      :content => params[:content]
    })
    
    redirect to("/blog/#{params[:username]}/#{params[:post_id]}#comments")
  end
  
  #########################
  # Delete comment routes #
  #########################
  
  get "/blog/:username/:post_id/:comment_id/delete_confirm" do
    @user = User.find_by_username(params[:username])
    @old_comment = Comment.find(params[:comment_id])
    
    erb :delete
  end
  
  post "/blog/:username/:post_id/:comment_id/delete_comment" do
    @user = User.find_by_username(params[:username])
    @post = Post.find(params[:post_id])
    old_comment = Comment.find(params[:comment_id])
    
    Comment.delete(old_comment.id)
    
    redirect to("/blog/#{params[:username]}/#{params[:post_id]}#comments")
  end
end