json.extract! activity, :id, :name, :description, :start_date, :balance, :created_at, :updated_at
json.url activity_url(activity, format: :json)
