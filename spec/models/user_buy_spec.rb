require 'rails_helper'

RSpec.describe UserBuy, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @user_buy = FactoryBot.build(:user_buy, user_id: user.id, item_id: item.id)
    sleep(1)
  end

  context '商品を購入できる時' do
    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@user_buy).to be_valid
    end

    it '建物名がなくても購入できる' do
      @user_buy.building = nil
      expect(@user_buy).to be_valid
    end
  end

  context '商品を購入できない時' do
    it '正しいクレジットカードの情報で無いときは決済できないこと' do
      @user_buy.token = nil
      @user_buy.valid?
      expect(@user_buy.errors.full_messages).to include("Token can't be blank")
    end

    it '郵便番号が空だと保存できないこと' do
      @user_buy.post_code = ''
      @user_buy.valid?
      expect(@user_buy.errors.full_messages).to include("Post code can't be blank")
    end

    it '郵便番号が全角だと保存できないこと' do
      @user_buy.post_code = '１２３ー４５６７'
      @user_buy.valid?
      expect(@user_buy.errors.full_messages).to include('Post code is invalid. Please input half-width characters.')
    end

    it '郵便番号はハイフンがないとの保存できないこと' do
      @user_buy.post_code = '1234567'
      @user_buy.valid?
      expect(@user_buy.errors.full_messages).to include('Post code is invalid. Please input half-width characters.')
    end

    it '都道府県が空だと保存できないこと' do
      @user_buy.area_id = 0
      @user_buy.valid?
      expect(@user_buy.errors.full_messages).to include("Area can't be blank")
    end

    it '市区町村が空だと保存できないこと' do
      @user_buy.city = ''
      @user_buy.valid?
      expect(@user_buy.errors.full_messages).to include("City can't be blank")
    end

    it '市区町村が半角だと保存できないこと' do
      @user_buy.city = 'tokyo'
      @user_buy.valid?
      expect(@user_buy.errors.full_messages).to include('City is invalid. Input full-width characters.')
    end

    it '番地が空だと保存できないこと' do
      @user_buy.house_number = ''
      @user_buy.valid?
      expect(@user_buy.errors.full_messages).to include("House number can't be blank")
    end

    it '電話番号が空だと保存できないこと' do
      @user_buy.phone_number = ''
      @user_buy.valid?
      expect(@user_buy.errors.full_messages).to include("Phone number can't be blank", 'Phone number is invalid')
    end

    it '電話番号は11桁以内の数値のみ保存可能なこと' do
      @user_buy.phone_number = '090123456789'
      @user_buy.valid?
      expect(@user_buy.errors.full_messages).to include('Phone number is invalid')
    end

    it '電話番号は英数混合では登録できないこと' do
      @user_buy.phone_number = '090abed6789'
      @user_buy.valid?
      expect(@user_buy.errors.full_messages).to include('Phone number is invalid')
    end

    it 'Userが紐づいていないと保存できないこと' do
      @user_buy.user_id = nil 
      @user_buy.valid?
      expect(@user_buy.errors.full_messages).to include("User can't be blank")
    end

    it 'Itemが紐づいていないと保存できないこと' do
      @user_buy.item_id = nil 
      @user_buy.valid?
      expect(@user_buy.errors.full_messages).to include("Item can't be blank")
    end
  end
end
