class AddForignKeyToOrders < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :user, :order
  end
end
