class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:login]

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  scope :from_poland, -> { where(country: "Poland") }

  def admin?
    self.role == 'admin'
  end

  def vip?
    self.role == 'vip'
  end

  def user?
    self.role == 'user'
  end

  attr_writer :login

  def login
    @login || self.username || self.email
  end

  def set_default_role
    self.role ||= :user
  end

  validates :name, :email, presence: true

  #Part of code, which adding possibility for users to login by their username and email.
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
  #End of part for login upgrade

  def address
    @address ||= Address.new(country, city, street, postcode)
  end

  def address=(address)
    self[:address_country] = address.country
    self[:address_city] = address.city
    self[:address_street] = address.street
    self[:address_postcode] = address.postcode
    @address = address
  end
end

class Address
  attr_reader :country, :city, :street, :postcode

  def initialize(country, city, street, postcode)
    @country, @city, @street, @postcode = country, city, street, postcode
  end

  def ==(other_address)
    country == other_address.country && city == other_address.city && street == other_address.street && postcode == other_address.postcode
  end

  def full?
    not (country.nil? || city.nil? || street.nil? || postcode.nil?)
  end
end