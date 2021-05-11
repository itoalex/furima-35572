class ItemRecord < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one    :ship_info
end
