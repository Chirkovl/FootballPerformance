class Player < ApplicationRecord
  belongs_to :team
  has_many :performances

  def has_performance?(performance)
    performances.exists?(performance: performance)
  end

  def last_five_matches
    team.matches.order(date: :desc).limit(5)
  end

  def has_performance_in_last_five_matches?(performance)
    last_five_matches.joins(:performances).where(performances: { player_id: id, performance: performance }).exists?
  end

  def mark_performance(performance, match)
    performances.create(performance: performance, match: match)
  end

  def self.top_players_by_performance(performance, team = nil)
    relation = Player.joins(:performances)
                     .where(performances: { performance: performance })
                     .group(:id)
                     .order(Arel.sql('COUNT(performances.id) DESC'))
                     .limit(5)
  
    if team.present?
      relation = relation.where(team: team)
    end
  
    relation
  end
end