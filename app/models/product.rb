class Product < ApplicationRecord
  has_many :comments
  belongs_to :category
  has_many :order_items

  enum currency: {PLN: 'PLN', EUR: 'EUR'} #, USD: 'USD', GBP: 'GBP', JPY: 'JPY'}

  scope :with_long_title, -> { where("LENGTH(title) > 15") }

  def cost
    @address ||= MoneyObject.new(price, currency)
  end

  def cost=(cost)
    self[:cents] = cost.cents
    self[:currency] = cost.currency.to_s
    @cost = cost
  end
end

class MoneyObject
  attr_reader :price, :currency, :pln_value

  def initialize(price, currency)
    @price, @currency = price, currency
    @pln_value = case currency
                 when currency == "PLN" then price
                 when currency == "EUR" then price * 0.22
                 end
  end

  def <=> (other_mo)
    @pln_value <=> other_mo.pln_value
  end

  def ==(other_mo)
    price == other_mo.price && currency == other_mo.currency
  end

  def full?
    not (price.nil? || currency.nil?)
  end

  def to_s
    "#{self.cost} #{self.currency}"
  end
end
