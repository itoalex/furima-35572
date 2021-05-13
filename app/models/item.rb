class Item < ApplicationRecord
  belongs_to :user
  has_one    :item_record

  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :area
  belongs_to :day
  belongs_to :ship_fee
  belongs_to :status

  with_options numericality: { other_than: 0 } do
    validates :category_id
    validates :area_id
    validates :day_id
    validates :ship_fee_id
    validates :status_id
  end

  with_options presence: true do
    validates :image
    validates :name
    validates :describe
    validates :category_id
    validates :status_id
    validates :ship_fee_id
    validates :area_id
    validates :day_id
    validates :price, inclusion: { in: 300..9_999_999 }, format: { with: /\A[0-9]+\z/ }
  end

  validates :price, numericality: true
end
