json.extract! account, :id, :name, :email, :passsword, :created_at, :updated_at
json.url account_url(account, format: :json)
