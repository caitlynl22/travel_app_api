class Location < ApplicationRecord
  has_many :destinations
  has_many :trips, through: :destinations

  validates :country, presence: true
  validates :country, inclusion: { in: Country.all, message: "Please choose a valid country." }

end
