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
      "A edit post form" # Continiuing if they are
    end
  end

end
