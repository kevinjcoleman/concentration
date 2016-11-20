require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should have_many(:games) }
  it { should have_many(:game_players) }
  it { should have_many(:game_cards) }
  it { should validate_presence_of(:playername) }
end
