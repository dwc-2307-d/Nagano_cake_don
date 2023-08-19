class Item < ApplicationRecord
  #アソシエーション
  has_one_attached :image
  belongs_to :genre
  has_many :cart_items
  has_many :order_item
  
  #バリデーション
  validates :is_status, inclusion: { in: [true, false], message: "の選択は必須です" }

  #インスタンス
  def item_status
    if is_status == true
      "販売中"
    else 
      "販売停止中"
    end
  end
  
  def with_tax_price
    (price * 1.1).floor
  end
  
  
end


