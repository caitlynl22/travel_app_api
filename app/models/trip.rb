class Trip < ApplicationRecord
  has_many :destinations
  has_many :locations, through: :destinations

  validates :title, presence: true
  validates :from, presence: true
  validates :to, presence: true
end
