class AddRatingToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :rate, :integer
  end
end
