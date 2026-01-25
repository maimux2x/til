users = [
  { id: 1, name: "Alice", team_id: 10 },
  { id: 2, name: "Bob",   team_id: 20 },
  { id: 3, name: "Carol", team_id: 10 }
]

teams = [
  { id: 10, name: "Backend" },
  { id: 20, name: "Frontend" }
]

team_names = teams.map(&:values).to_h

users.map { |user|
  { **user.except(:team_id), team: team_names[user[:team_id]] }
}
