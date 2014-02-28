json.array!(@users) do |user|
  json.extract! user, :id, :name, :email_address, :password, :crew_id
  json.url user_url(user, format: :json)
end
