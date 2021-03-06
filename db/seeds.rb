User.create!(first_name: "Example",
	last_name: "User",
	email: "example@example.com",
	password: "foobar",
	password_confirmation: "foobar",
	admin: true,
	activated: true,
	activated_at: Time.zone.now)

99.times do |n|
	first_name = Faker::Name.first_name
	last_name = Faker::Name.last_name
	email = "example-#{n+1}@railstutorial.org"
	password = "password"
	User.create(first_name: first_name,
		last_name: last_name,
		email: email,
		password: password,
		password_confirmation: password,
		activated: true,
		activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
	users.each do |user|
		content = Faker::Lorem.sentence(5)
		user.microposts.create(content: content)
	end
end