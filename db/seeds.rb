team_a = Team.create(name: 'Lannisters')
team_b = Team.create(name: 'Starks')

player_a1 = Player.create(name: 'Joffrey Baratheon', team: team_a)
player_a2 = Player.create(name: 'Gregor Clegane', team: team_a)
player_a3 = Player.create(name: 'Cersei Lannister', team: team_a)

player_b1 = Player.create(name: 'Jon Snow', team: team_b)
player_b2 = Player.create(name: 'Arya Stark', team: team_b)
player_b3 = Player.create(name: 'Brienne of Tarth', team: team_b)

match_1 = Match.create(date: Date.today - 7)
match_2 = Match.create(date: Date.today - 6)
match_3 = Match.create(date: Date.today - 5)

MatchTeam.create(match: match_1, team: team_a)
MatchTeam.create(match: match_2, team: team_a)
MatchTeam.create(match: match_3, team: team_a)

MatchTeam.create(match: match_1, team: team_b)
MatchTeam.create(match: match_2, team: team_b)
MatchTeam.create(match: match_3, team: team_b)

player_a1.mark_performance('10+ km', match_1)
player_a1.mark_performance('70+ % accurate passes', match_1)
player_a2.mark_performance('10+ km', match_1)
player_a3.mark_performance('70+ % accurate passes', match_1)

player_a1.mark_performance('10+ km', match_2)
player_a1.mark_performance('70+ % accurate passes', match_2)
player_a2.mark_performance('10+ km', match_2)
player_a2.mark_performance('70+ % accurate passes', match_2)

player_a1.mark_performance('10+ km', match_3)
player_a1.mark_performance('70+ % accurate passes', match_3)

player_b1.mark_performance('10+ km', match_1)
player_b2.mark_performance('10+ km', match_1)
player_b2.mark_performance('70+ % accurate passes', match_1)
player_b3.mark_performance('70+ % accurate passes', match_1)

player_b1.mark_performance('10+ km', match_2)
player_b1.mark_performance('70+ % accurate passes', match_2)
player_b2.mark_performance('70+ % accurate passes', match_2)
player_b2.mark_performance('70+ % accurate passes', match_3)
