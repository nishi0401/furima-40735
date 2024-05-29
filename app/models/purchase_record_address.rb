class PurchaseRecordAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :block, :building, :phone_number, :token

  validates :token, presence: true

  with_options presence: true do
    validates :user_id, :item_id, :city, :block, presence: true
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid' }
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    # 寄付情報を保存し、変数donationに代入する
    purchase_record = PurchaseRecord.create(user_id:, item_id:)
    # 住所を保存する
    # donation_idには、変数donationのidと指定する
    Address.create(postcode:, prefecture_id:, city:, block:, building:,
                   phone_number:, purchase_record_id: purchase_record.id)
  end
end
