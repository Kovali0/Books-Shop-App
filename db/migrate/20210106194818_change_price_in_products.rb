class ChangePriceInProducts < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      change_table :products do |t|
        dir.up   { t.change :cents, :decimal }
        dir.down { t.change :cents, :integer }
      end
    end
  end
end
