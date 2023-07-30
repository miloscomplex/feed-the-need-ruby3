class Sessions::SessionsController < ApplicationController
    
    include SessionsHelper
    
    def login
      #flash.now[:messages] = "Incorrect Password or Username"
      # @donator = Donator.new
    end
  
    def create
      @donator = Donator.find_by(email: params[:email])
      @needy = Needy.find_by(email: params[:email])
      if @donator && @donator.authenticate(params[:password])
        session[:user_id] = @donator.id
        session[:user_type] = :donator
        redirect_to donator_path(@donator)
      elsif @needy && @needy.authenticate(params[:password])
        session[:user_id] = @needy.id
        session[:user_type] = :needy
        redirect_to needy_path(@needy)
      else
        flash[:error] = "Incorrect Password or Username"
        redirect_to login_path
      end
    end
  
    def logout
      logout!
      redirect_to root_path
    end
  
    def google_login
      user_email = request.env['omniauth.auth']['info']['email']
      user_name = request.env['omniauth.auth']['info']['name']
      @donator = Donator.find_or_create_by(email: user_email) do |user|
        user.name = user_name
        user.password = SecureRandom.hex
      end
      session[:user_id] = @donator.id
      session[:user_type] = :donator
      redirect_to donator_path(@donator)
    end
  
  end
  