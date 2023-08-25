class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_items

  validates :post_code, presence: true
  validates :address, presence: true
  validates :name, presence: true

  #支払い方法
  enum payment_method: {credit_card: 0, transfer: 1}

  #注文ステータス
  enum status: {wait_payment: 0, confirm_payment: 1, making: 2, preparing_ship: 3, finish_prepare: 4}

end
