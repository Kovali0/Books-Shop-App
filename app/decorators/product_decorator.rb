class ProductDecorator < ApplicationDecorator
  delegate_all

  def full_cost
    "#{self.cost.price}#{self.cost.currency}"
  end

  def total_rating
    sum = 0
    if self.comments.count > 0
      self.comments.all.each do |comment|
        sum = sum + comment.rate
      end
      rate = sum / self.comments.count
    else
      rate = 5
    end
    "#{rate}"
  end
end
