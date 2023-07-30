class Needies::ItemsController  < ApplicationController
  include NeediesHelper

  before_action :require_needy_login, :verify_user


  def new
    if params[:needy_id] && @needy.items.exists?
      redirect_to needy_path(@needy), flash: { error: "You have already created your first 3 items" }
    else
      @item = Item.new()
      # nested form add nested form object
      @items = @needy.items
    end
  end

  def create
    # has_many nested
    # binding.pry
    @needy.items.build([{name: item_params[:name_0], quantity: item_params[:quantity_0]}, {name: item_params[:name_1], quantity: item_params[:quantity_1]}, {name: item_params[:name_2], quantity: item_params[:quantity_2]}])
    # @item = Item.new(item_params)
    if @needy.save
      redirect_to needy_path(@needy)
    else
      render :new
    end
  end

  def show
    redirect_to needy_path(@needy)
  end

  def edit
    if params[:needy_id]
      if @needy.nil?
        redirect_to login_path, flash: { error: "Needy list not found. items_controller" }
      else
        @items = @needy.not_donated
        @item = Item.new(needy_id: params[:needy_id])
        redirect_to needy_path(needy), alert: "Item not found." if @needy.nil?
      end
    end
  end

  def update
    if item_params.nil? || items_params[:items].nil?
      flash[:error] = "Uh oh, something went wrong"
      redirect_to needy_path(@needy)
    else
      item_params[:items].each do |k,v|
        @item = Item.find_by(id: k)
        @item.update(name: v[:name], quantity: v[:quantity])
      end
    end
    if item_params[:name].present?
      # add new item
      @needy.items.build(name: item_params[:name], quantity: item_params[:quantity])
      if @needy.save
        flash[:alert] = "Item(s) saved!"
      else
        flash[:error] = "Uh oh, something went wrong"
      end
    end
    flash[:alert] = "Items have been updated."
    redirect_to needy_path(@needy)
  end

  def destroy
    @needy.items.destroy_all
    redirect_to needy_path(@needy)
  end

  private

  def item_params
    params.permit(:needy_id, :name, :quantity, :name_0, :quantity_0, :name_1, :quantity_1, :name_2, :quantity_2, items: [ :id, :name, :quantity])
  end

  def verify_user
    if current_user != Needy.find_by(id: params[:needy_id])
      flash[:error] = "Uh oh, something went wrong"
      redirect_to needy_path(current_user.id)
    else
      @needy = Needy.find_by(id: params[:needy_id])
    end
  end

end
