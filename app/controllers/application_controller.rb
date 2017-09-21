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
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    #at this point @user variable displays correctly
    @user.save
    # at this point @user variable also displays correctly...
    session[:id] = @user.id
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

    # underneath this is a SQL and query, for which both parameters must be
    # satisified.
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id
    redirect '/users/home'
  end

  # clear the session hash
  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  # render the users homepage view
  get '/users/home' do

    # right, so the way that we pass the user object from one
    # controller > view to another is by looking it up with session id
    # which is set on the first page the user logs into
    @user = User.find(session[:id])

    erb :'/users/home'
  end

end
