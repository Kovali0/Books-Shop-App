class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    "#{self.name} #{self.surname}"
  end

end
