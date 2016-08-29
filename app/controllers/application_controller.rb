class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  helpers do

    def logged_in?
      !!session[:email] # Double negation converts from actual value to truthy value of object
    end

    def login(email, password)
      # Check if a user with this email actually exists
      user = User.find_by(:email => email)
      if user && user.authenticate(password)
          session[:email] = user.email
      else
        redirect '/login'
      end
    end

    def logout!
      session.clear
    end

  end

end
