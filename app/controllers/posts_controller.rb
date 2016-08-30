class PostsController < ApplicationController

  get '/posts' do
    "A list of publically available posts"
  end

  get '/posts/new' do
    # Checking if they are logged in
    if !logged_in?
      redirect "/login" # Redirecting if they're not
    else
      "A new post form" # Continiuing if they are
    end
  end

  get '/posts/:id/edit' do
    if !logged_in?
      redirect "/login" # Redirecting if they're not
    else
      # post = Post.find(params[:id])
      # if post.user_id == current_user.id
      #   "A edit post form #{current_user.id} is editing #{post.id}"
      # else
      #   redirect '/posts'
      # end
        ##### or
      # post = current_user.posts.find(params[:id])
      # "A edit post form #{current_user.id} is editing #{post.id}"
        #### ^ will cause program to break if someone uses incorrectly because of .find vs .find_by return values
      if post = current_user.posts.find(params[:id])
        "A edit post form #{current_user.id} is editing #{post.id}"
      else
        redirect '/posts'
      end
    end
  end

end
