class Donator < ApplicationRecord
  has_secure_password
  has_many :items
  # need to further explore utitizling source
  # has_many :donated_items, through: :items, source: :needy
  has_many :needy, through: :items
  accepts_nested_attributes_for :items

  validates :name, :email, presence: true
  # validates :name, format: { with: /\w+, \w+/, message: "A first and last is required" }
  validates :password, presence: true, on: :create
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :email_in_use
  validates :password, confirmation: true, on: :create
  validate :donation_count 

  def donation_count
    Item.all.where(donator_id: self.id ).count
    # self.items.count
  end

  private

  def email_in_use
    if Needy.find_by(email: self.email)
      errors.add(:email, "This is email is already registered as a person in need")
    end
  end

end
