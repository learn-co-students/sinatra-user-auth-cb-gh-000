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

  get '/users/home' do
    # current_user_id = session[:current_user]
    # @user = User.find_by_id(current_user_id)
    @user = User.find(session[:id])
    erb :'/users/home'
    erb :'/users/home'
  end

  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  post '/registrations' do
    # @user = User.create(params)
    # session[:current_user] = @user.id
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
    @user.save
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    # @user = User.find_by(email: params[:email])
    # if @user.password == params[:password]
    # session[:current_user] = @user.id
    # redirect '/users/home'
    # else
    #    'Wrong information'
    # end
    @user = User.find_by(email: params["email"], password: params["password"])
    session[:id] = @user.id
    redirect '/users/home'
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  # get '/users/home' do
  #
  #   erb :'/users/home'
  # end

end
