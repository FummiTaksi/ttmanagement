json.extract! player, :id, :name, :birthday, :age, :clubowner, :admin, :created_at, :updated_at
json.url player_url(player, format: :json)
