class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



  validates :last_name,       presence: true
  validates :last_name_kana,  presence: true
  validates :first_name,      presence: true
  validates :first_name_kana, presence: true
  validates :email,           presence: true, uniqueness: true
  validates :post_code,       presence: true, format: { with: /\A\d{7}\z/, allow_blank: true}
  validates :address,         presence: true
  validates :telephone_number,    presence: true, format: { with: /\A0\d{9,10}\z/, allow_blank: true}

  def full_name
    last_name + '' + first_name
  end

  def full_name_kana
    last_name_kana + '' + first_name_kana
  end

  def customer_status
    if is_deleted == true
      "退会"
    else
      "有効"
    end
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end
end
