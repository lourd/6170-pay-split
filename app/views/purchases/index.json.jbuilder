json.array!(@purchases) do |purchase|
  json.extract! purchase, 
  json.url purchase_url(purchase, format: :json)
end
