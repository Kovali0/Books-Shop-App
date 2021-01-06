class Product < ApplicationRecord
  has_one :price
  has_many :comments
  belongs_to :category
end
