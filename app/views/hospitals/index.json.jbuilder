json.array!(@hospitals) do |hospital|
  json.extract! hospital, :name, :short_name, :spell_code, :address, :phone, :description, :rank
  json.url hospital_url(hospital, format: :json)
end
