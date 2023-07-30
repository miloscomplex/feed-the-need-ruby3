class Needy < ApplicationRecord
  has_secure_password

  has_many :items, dependent: :destroy
  has_many :donators, through: :items
  accepts_nested_attributes_for :items


  validates :name, :email, :bio, presence: true
  validates :email, uniqueness: { case_sensitive: false } #avoids duplicate emails that just vary in case
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } #utiilizing mail REGEX to validate email format
  validate :email_in_use
  validates :password, presence: true, on: :create

  def first_name
    first_name = self.name.split(/ /)
    first_name.first
  end

  def not_donated
    self.items.select do |item|
      item.donator_id.nil?
    end
  end

  private

  def email_in_use
    if Donator.find_by(email: self.email)
      errors.add(:email, "This is email is already registered as a Donator")
    end
  end

end
