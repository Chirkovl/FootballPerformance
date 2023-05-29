# spec/models/player_spec.rb
require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:team) }
    it { is_expected.to have_many(:performances) }
  end

  describe '.top_players_by_performance' do
    let!(:team_a) { FactoryBot.create(:team) }
    let!(:team_b) { FactoryBot.create(:team) }
    let!(:match_1) { FactoryBot.create(:match, team: team_a) }
    let!(:player1) { FactoryBot.create(:player, team: team_a) }
    let!(:player2) { FactoryBot.create(:player, team: team_a) }
    let!(:player3) { FactoryBot.create(:player, team: team_b) }
    let!(:performance1) { FactoryBot.create(:performance, player: player1, match: match_1, performance: '10+ km') }
    let!(:performance2) { FactoryBot.create(:performance, player: player2, match: match_1, performance: '10+ km') }
    let!(:performance3) { FactoryBot.create(:performance, player: player3, match: match_1, performance: '10+ km') }

    it 'returns top players by performance for the specified team' do
      top_players = Player.top_players_by_performance('10+ km', team_a)

      expect(top_players).to include(player1)
      expect(top_players).to include(player2)
      expect(top_players).not_to include(player3)
      expect(top_players.size).to eq(2)
    end

    it 'returns top players by performance for all teams if team is not specified' do
      top_players = Player.top_players_by_performance('10+ km')

      expect(top_players).to include(player1)
      expect(top_players).to include(player2)
      expect(top_players).to include(player3)
      expect(top_players.size).to eq(3)
    end
  end
end
