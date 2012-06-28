namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		make_users
		make_microposts
		make_relationships
	end
end

def make_users
	#create a sample admin
	admin = User.create!(name: "Example User",
				email: "example@railstutorial.org",
				password: "foobar",
				password_confirmation: "foobar")
	admin.toggle!(:admin)
	puts "Created a sample admin"

	#create 99 people
	99.times do	|n|
		name = Faker::Name.name
		email = "example-#{n+1}@railstutorial.org"
		password = "password"
		User.create!(name: name,
					email: email,
					password: password,
					password_confirmation: password)
	end
	puts "Created 99 users"
end

def make_microposts
	#create microposts for people
	users = User.all(limit: 6)
	50.times do
		content = Faker::Lorem.sentence(5)
		users.each { |user| user.microposts.create!(content: content) }
	end
	puts "Created 50 microposts for first 6 users"
end

def make_relationships
	users = User.all
	user = users.first
	followed_users  = users[2..50]
	followers 		= users[3..40]
	followed_users.each { |followed| user.follow!(followed) }
	followers.each		{ |follower| follower.follow!(user) }
end
