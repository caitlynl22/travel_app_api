class Location < ApplicationRecord
  has_many :destinations
  has_many :trips, through: :destinations
end
