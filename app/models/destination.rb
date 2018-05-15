class Destination < ApplicationRecord
  belongs_to :trip
  belongs_to :location
end
