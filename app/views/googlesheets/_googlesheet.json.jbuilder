json.extract! googlesheet, :id, :sport, :link, :created_at, :updated_at
json.url googlesheet_url(googlesheet, format: :json)