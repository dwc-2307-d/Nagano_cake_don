class ChangeColumnInOrders < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :postcode, :post_code
  end
end
