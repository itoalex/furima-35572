class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :item_records

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: 'は半角で英字と数字の両方を含めて設定してください' }

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶー-龥々]+\z/, message: 'は全角文字を使用してください' } do
    validates :last_name
    validates :first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶ]+\z/, message: 'は全角カタカナを使用してください' } do
    validates :last_name_kana
    validates :first_name_kana
  end

  validates :nickname, presence: true
  validates :birth_day, presence: true
end
