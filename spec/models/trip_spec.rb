require 'rails_helper'

RSpec.describe Trip, type: :model do
  it { should have_many(:destinations) }
  it { should have_many(:locations) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:from) }
  it { should validate_presence_of(:to) }
end
