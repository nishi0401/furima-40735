class PurchaseRecordsController < ApplicationController
  before_action :move_to_other_pages, only: [:index]

  def index
    @item = Item.find(params[:item_id])
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @purchase_record_address = PurchaseRecordAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_record_address = PurchaseRecordAddress.new(purchase_record_params)
    if @purchase_record_address.valid?
      pay_item
      @purchase_record_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_record_params
    params.require(:purchase_record_address).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_record_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_other_pages
    if user_signed_in?
      item = Item.find(params[:item_id])
      if current_user.id == item.user.id
        redirect_to root_path
      elsif current_user.id != item.user.id && item.purchase_record.present?
        redirect_to root_path
      end
    else
      redirect_to new_user_session_path
    end
  end
end
