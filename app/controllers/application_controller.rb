class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  # remember that we need this block to enable a sessions hash
  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :home
  end

  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  post '/registrations' do

    redirect '/users/home'
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  # get user data from params hash. Uses activerecord .find_by method to
  # check to see if an instance with this data exists:
  # User.find_by(email: params[:email], password: params[:password])
  # If yes, store user ID as the value of session[:id]
  post '/sessions' do

    redirect '/users/home'
  end

  # clear the session hash
  get '/sessions/logout' do

    redirect '/'
  end

  # render the users homepage view
  get '/users/home' do

    erb :'/users/home'
  end

end
