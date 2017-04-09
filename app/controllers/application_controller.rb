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

  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  post '/registrations' do
    user = User.create(params[:user])
    session[:user_id] = user.id
    redirect '/users/home'
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    #binding.pry
    user = user_exist? params[:user]
    if user
      session[:user_id] = user.id
      redirect '/users/home'
    else
      "undefined method `id' for nil:NilClass"
    end
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end

  get '/users/home' do
    @user = User.find(session[:user_id])
    erb :'/users/home'
  end

  private
  def user_exist? user_params
    @user = User.find_by(email: user_params[:email],
                      password: user_params[:password])
  end

end
