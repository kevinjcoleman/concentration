require 'rails_helper'

RSpec.describe GamePlayer, type: :model do
  it { should belong_to(:player) }
  it { should belong_to(:game) }
  it { should validate_presence_of(:role) }
  it do  
    should validate_inclusion_of(:role).
     in_array([1, 2])
  end
end
