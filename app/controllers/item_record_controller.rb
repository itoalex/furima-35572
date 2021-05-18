class ItemRecordController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :redirect_root, only: [:index, :create]

  def index
    @user_buy = UserBuy.new
  end

  def create
    @user_buy = UserBuy.new(item_record_params)
    if @user_buy.valid?
      pay_item
      @user_buy.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def item_record_params
    params.require(:user_buy).permit(:post_code, :area_id, :city, :house_number, :building, :phone_number, :price).merge(
      user_id: current_user.id, token: params[:token], item_id: params[:item_id]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: item_record_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find_by(id: params[:item_id])
  end

  def redirect_root
    redirect_to root_path if current_user.id == @item.user_id || @item.item_record.present?
  end
end
