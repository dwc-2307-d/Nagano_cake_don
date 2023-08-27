class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validate :item_must_be_available

  def total_price
    item.price * quantity
  end
  
  private
  
  def item_must_be_available
    if item && !item.is_status
      errors.add(:item, "は現在販売停止中です。")
    end
  end
end

  