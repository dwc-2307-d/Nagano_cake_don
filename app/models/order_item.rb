class OrderItem < ApplicationRecord
  
  belongs_to :order
  belongs_to :item
  
  #制作ステータス
  enum manufacture_status: {impossible_manufacture:0, waiting_manufacture:1, manufacturing:2, finish:3}

end
