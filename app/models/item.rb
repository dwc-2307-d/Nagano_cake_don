class Item < ApplicationRecord
  # Associations
  has_one_attached :image
  belongs_to :genre
  has_many :cart_items
  has_many :order_items

  # Validations
  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :genre_id, presence: true
  validates :is_status, inclusion: { in: [true, false], message: "の選択は必須です" }

  # 検索
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "genre_id", "id", "is_status", "name", "price", "updated_at"]
  end

  # Instance methods
  def item_status
    is_status ? "販売中" : "販売停止中"
  end

  def with_tax_price
    (price * 1.1).floor
  end
end

