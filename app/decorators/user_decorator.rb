class UserDecorator < Draper::Decorator
  delegate_all

  def full_name
    "#{self.name} #{self.surname}"
  end

  def full_address
    "#{self.address.country}"+"\n"+
    "Post-code: #{self.address.postcode}"+"\n"+
    "#{self.address.city} #{self.address.street}"
  end

end
