class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do 
    erb :home
  end
  
  # Render sign-up form view 
  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  # Handles POST request when user hits submit on sign-up form
  # Gets user info from params hash, create new user, signs in, redirects elsewhere
  post '/registrations' do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id
    puts params
    redirect '/users/home'
  end

  # Renders login form 
  get '/sessions/login' do
    erb :'sessions/login'
  end

  # Recieves POST request when user hits submit on login form 
  # Takes user's info from params hash, matches info against existing entries in db, 
  # if matching entry is found, user is signed in 
  post '/sessions' do
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id
    redirect '/users/home'
  end

  # Logs out user by clearning session hash
  get '/sessions/logout' do 
    session.clear
    redirect '/'
  end

  # Renders user's homepage view 
  # Route finds current user based on ID val stored in session hash 
  # Sets instance variable to @user to equal to that user, can access curr user in view
  get '/users/home' do
    @user = User.find(session[:id])
    erb :'/users/home'
  end

end