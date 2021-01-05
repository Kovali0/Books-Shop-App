class Price < ApplicationRecord
  enum currency: {eur: 0, usd: 1}
  belongs_to :product

  def to_s
    "#{self.cost} #{self.currency}"
  end

  #@todo Use money gem
  #def f_cost
  #Money.new(cost, currency)
  #end
end
