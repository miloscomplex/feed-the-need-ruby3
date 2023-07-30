class Needies::UsersController < ApplicationController
  include NeediesHelper

  before_action :require_needy_login, except: [:new, :create]
  before_action :set_needy, only: [:show, :edit, :update, :destroy]

  def new
    @needy = Needy.new
  end

  def index
    redirect_to needy_path(current_user.id)
  end

  def show
    @donated_items = @needy.items.where.not('donator_id' => nil)
  end

  def create
    @needy = Needy.new(user_params)
    if @needy.save
      session[:user_id] = @needy.id
      session[:user_type] = :needy
      redirect_to needy_path(@needy)
    else
      render :new
    end
  end


  def update
    @needy.update(user_params)
    redirect_to needy_path(@needy)
  end

  def destroy
    @needy.destroy
    redirect_to needy_path(@needy)
  end


  private

  # Returns the current logged-in user (if any).
  def current_user
    if is_donator?
      @current_user ||= Donator.find_by(id: session[:user_id])
    elsif is_needy?
      @current_user ||= Needy.find_by(id: session[:user_id])
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !!current_user
  end

  def user_params
    params.require(:needy).permit(:name, :email, :bio, :password, :password_confirmation)
  end

  def set_needy
    if current_user != Needy.find_by(id: params[:id])
      flash[:error] = "Uh oh, something went wrong"
      redirect_to login_path
    else
      @needy = Needy.find_by(id: params[:id])
    end
  end

end
