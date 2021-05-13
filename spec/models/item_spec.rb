require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品を出品できる時' do
      it 'name,describe,category_id,status_id,ship_fee_id,area_id,day_id,priceが存在すれば登録できること' do
        expect(@item).to be_valid
      end

      it 'priceが¥300で保存可能なこと' do
        @item.price = 300
        expect(@item).to be_valid
      end

      it 'priceが¥9,999,999で保存可能なこと' do
        @item.price = 9_999_999
        expect(@item).to be_valid
      end

      it 'priceが半角数字のみ保存可能であること' do
        @item.price = 300
        expect(@item).to be_valid
      end
    end

    context '商品を出品できない時' do
      it 'nameが空では登録できないこと' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'describeが空では登録できないこと' do
        @item.describe = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Describe can't be blank")
      end

      it 'category_idが空では登録できないこと' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 0')
      end

      it 'status_idが空では登録できないこと' do
        @item.status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Status must be other than 0')
      end

      it 'ship_fee_idが空では登録できないこと' do
        @item.ship_fee_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Ship fee must be other than 0')
      end

      it 'area_idが空では登録できないこと' do
        @item.area_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Area must be other than 0')
      end

      it 'day_idが空では登録できないこと' do
        @item.day_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Day must be other than 0')
      end

      it 'priceが空では登録できないこと' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが全角だと登録できないこと' do
        @item.price = '１２３４５'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not included in the list')
      end

      it 'priceが半角英数混合だと登録できないこと' do
        @item.price = '300abc'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end

      it 'priceが半角英語だと登録できないこと' do
        @item.price = 'money'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not included in the list')
      end

      it 'priceが¥300以下だと登録できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not included in the list')
      end

      it 'priceが¥9,999,999以上だと登録できないこと' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not included in the list')
      end
    end
  end
end
