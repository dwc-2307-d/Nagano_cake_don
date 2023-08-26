class Address < ApplicationRecord
  belongs_to :customer

  validates :name, :address, presence: true
  validates :address, length: { maximum: 50 }, presence: true
  validates :post_code, format: {with: /\A\d{7}\z/}, presence: true


#配送先情報の表示
  def full_address
    '〒' + post_code + ' ' + address + ' ' + name
  end
end
