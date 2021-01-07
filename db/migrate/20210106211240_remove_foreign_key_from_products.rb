class RemoveForeignKeyFromProducts < ActiveRecord::Migration[6.1]
  def change
    remove_reference :prices, :product, index: true, foreign_key: true
  end
end
