json.array!(@profiles) do |profile|
  json.extract! profile, :avatar, :first_name, :last_name, :gender, :website, :locale, :bio, :user_id
  json.url profile_url(profile, format: :json)
end
