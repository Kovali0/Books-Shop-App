class ChangeColumnNameInProducts < ActiveRecord::Migration[6.1]
  def change
    rename_column  :products, :cents, :price
  end
end
