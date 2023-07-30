class Donators::UsersController < ApplicationController
  include DonatorsHelper

  before_action :require_donator_login, except: [:login, :new, :create]
  before_action :set_donator, only: [:show, :edit, :update, :destroy]

  def new
    @donator = Donator.new
  end

  def create
    @donator = Donator.new(user_params)
    if @donator.save
      session[:user_id] = @donator.id
      session[:user_type] = :donator
      redirect_to donator_path(@donator)
    else
      # flash[:messages] = "Something went wrong"
      render :new
    end
  end

  def index
    if current_user
      redirect_to donator_path(current_user.id)
    end
    #donator helper redirects with message if not logged_in
  end

  def show
    @needies = Needy.all
    @activity = Item.where(donator_id: @donator.id).last(3)
    @donation_count = @donator.donation_count
  end

  def update
    @donator.update(user_params)
    redirect_to donator_path(@donator)
  end

  def destroy
    binding.pry
    @donator.destroy
    redirect_to donator_path(@donator)
  end

  private

  def user_params
    params.require(:donator).permit(:name, :email, :about, :password, :password_confirmation, :donate_items )
  end

  def set_donator
    if current_user != Donator.find_by(id: params[:id])
      flash[:error] = "Uh oh, something went wrong"
      redirect_to login_path
    else
      @donator = Donator.find_by(id: params[:id])
    end
  end

end
