class Trip < ApplicationRecord
  has_many :destinations
  has_many :locations, through: :destinations
end
