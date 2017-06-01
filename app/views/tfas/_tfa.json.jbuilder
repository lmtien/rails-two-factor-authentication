json.extract! tfa, :id, :user_id, :tfa_password, :attepmted, :created_at, :updated_at
json.url tfa_url(tfa, format: :json)
