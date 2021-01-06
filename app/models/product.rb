class Product < ApplicationRecord
  has_one :price
  has_many :comments
end
