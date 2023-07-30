class Donators::ItemsController < ApplicationController
  include DonatorsHelper
  #before_action :set_item, only: [:show]
  before_action :require_donator_login



  def show
    #@items = Item.all.where(donator_id: params[:donator_id])
    @user_id = params[:donator_id]
    @items = Item.all
  end

  def edit
    @items = Item.find_by(id: params[:id])
  end

  def update
    @items = Item.find(params[:id])
    @items.update(items_params)
    redirect_to donator_path(@items.donator_id)
  end

  private

  def set_item
    @item = Item.find_by(id: params[:id])
  end

  def items_params
    params.require(:item).permit(:donator_id)
  end

  def verify_user
    if current_user != Donator.find_by(id: params[:needy_id])
      flash[:error] = "Uh oh, something went wrong"
      redirect_to donator_path(current_user.id)
    end
  end

end
