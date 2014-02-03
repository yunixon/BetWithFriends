json.array!(@crews) do |crew|
  json.extract! crew, :id, :name
  json.url crew_url(crew, format: :json)
end
