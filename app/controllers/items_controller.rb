class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :show]
  before_action :move_to_new_user_session, only: [:new, :edit, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    return if current_user.id == @item.user.id

    redirect_to action: :index
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :title, :description, :price, :category_id, :condition_id, :shipping_cost_id,
                                 :prefecture_id, :shipping_date_id).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_new_user_session
    return if user_signed_in?

    redirect_to new_user_session_path
  end
end
