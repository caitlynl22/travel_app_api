require 'rails_helper'

RSpec.describe Location, type: :model do
  it { should have_many(:destinations) }
  it { should have_many(:trips) }
  it { should validate_presence_of(:country) }
end
