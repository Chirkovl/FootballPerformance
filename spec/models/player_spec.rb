# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:team) }
    it { is_expected.to have_many(:performances) }
  end

  describe '.has_performance?' do
    let!(:team) { FactoryBot.create(:team) }
    let!(:player) { FactoryBot.create(:player, team: team) }
    let!(:match1) { FactoryBot.create(:match) }
    let!(:performance1) { FactoryBot.create(:performance, player: player, match: match1, performance: '10+ km') }
    let!(:performance2) { FactoryBot.create(:performance, player: player, match: match1, performance: '70+ % accurate passes') }

    it 'returns true if the player has the specified performance' do
      expect(player.has_performance?('10+ km')).to be true
      expect(player.has_performance?('70+ % accurate passes')).to be true
    end

    it 'returns false if the player does not have the specified performance' do
      expect(player.has_performance?('5+ km')).to be false
      expect(player.has_performance?('90+ % pass accuracy')).to be false
    end
  end

  describe '.last_five_matches' do
    let!(:team) { FactoryBot.create(:team) }
    let!(:match1) { FactoryBot.create(:match, date: Date.today - 6) }
    let!(:match2) { FactoryBot.create(:match, date: Date.today - 5) }
    let!(:match3) { FactoryBot.create(:match, date: Date.today - 4) }
    let!(:match4) { FactoryBot.create(:match, date: Date.today - 3) }
    let!(:match5) { FactoryBot.create(:match, date: Date.today - 2) }
    let!(:match6) { FactoryBot.create(:match, date: Date.today - 1) }
    let!(:match_team1) { FactoryBot.create(:match_team, match: match1, team: team) }
    let!(:match_team2) { FactoryBot.create(:match_team, match: match2, team: team) }
    let!(:match_team3) { FactoryBot.create(:match_team, match: match3, team: team) }
    let!(:match_team4) { FactoryBot.create(:match_team, match: match4, team: team) }
    let!(:match_team5) { FactoryBot.create(:match_team, match: match5, team: team) }
    let!(:match_team6) { FactoryBot.create(:match_team, match: match6, team: team) }
    let!(:player) { FactoryBot.create(:player, team: team) }
  
    it 'returns the last five matches for the player\'s team' do
      expect(player.last_five_matches).to eq([match6, match5, match4, match3, match2])
    end
  
    it 'not return last 6th match' do
      expect(player.last_five_matches).not_to include(match1)
    end
  end
  
  describe '.mark_performance' do
    let!(:team) { FactoryBot.create(:team) }
    let!(:player) { FactoryBot.create(:player, team: team) }
    let!(:player2) { FactoryBot.create(:player, team: team) }
    let!(:match) { FactoryBot.create(:match) }

    it 'creates a new performance for the player in the specified match' do
      expect {
        player.mark_performance('10+ km', match)
      }.to change { Performance.count }.by(1)

      new_performance = Performance.last
      expect(new_performance.player).to eq(player)
      expect(new_performance.player).not_to eq(player2)
      expect(new_performance.match).to eq(match)
      expect(new_performance.performance).to eq('10+ km')
    end
  end

  describe '.top_players_by_performance' do
    let!(:team_a) { FactoryBot.create(:team) }
    let!(:team_b) { FactoryBot.create(:team) }
    let!(:match_1) { FactoryBot.create(:match) }
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
