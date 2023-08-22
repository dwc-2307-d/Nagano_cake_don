class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def total_price
    item.price * quantity
  end
end
