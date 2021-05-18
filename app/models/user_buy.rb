class UserBuy
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :post_code, :area_id, :city, :house_number, :building, :phone_number, :token, :item_record,
                :price

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Please input half-width characters.' }
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'is invalid. Input full-width characters.' }
    validates :house_number
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
  end
  validates :area_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :token, presence: true
  validates :user_id, presence: true
  validates :item_id, presence: true
 
  def save
    item_record = ItemRecord.create!(item_id: item_id, user_id: user_id)
    ShipInfo.create!(post_code: post_code, area_id: area_id, city: city, house_number: house_number, building: building,
                     phone_number: phone_number, item_record_id: item_record.id)
  end
end
