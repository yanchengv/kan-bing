json.array!(@technologies) do |technology|
  json.extract! technology, :id, :name, :desc, :period, :from, :create_by_user
  json.url technology_url(technology, format: :json)
end
