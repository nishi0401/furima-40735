class Item < ApplicationRecord
  belongs_to :user
  #has_one :purchase_record
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_date

  validates :image, :title, :description, :price, presence: true

  validates :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_date_id,
            numericality: { other_than: 1, message: "can't be blank" }

  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
