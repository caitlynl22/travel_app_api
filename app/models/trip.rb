class Trip < ApplicationRecord
  has_many :destinations
  has_many :locations, through: :destinations
  belongs_to :user

  validates :title, presence: true
  validates :from, presence: true
  validates :to, presence: true
end
