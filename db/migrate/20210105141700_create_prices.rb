class CreatePrices < ActiveRecord::Migration[6.1]
  def change
    create_table :prices do |t|
      t.decimal :cost, precision: 6, scale: 2
      t.integer :currency

      t.timestamps
    end
  end
end
