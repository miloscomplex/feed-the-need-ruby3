class Item < ApplicationRecord

  belongs_to :needy
  has_many :donators

  validates :name, :quantity, presence: true
  validates :name, uniqueness: { case_sensitive: false, scope: :needy_id, message: "You can only have one request per item" }

  def find_donator
    Donator.find_by(id: self.donator_id) unless self.donator_id.nil?
  end

end
