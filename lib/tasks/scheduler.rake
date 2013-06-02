# Daily task run with Heroku Scheduler
# Batch 1 - 25% of active users
# Time set to 13:00 UTC
desc "Get unfollowers (Batch 1)"
task :get_unfollowers_b1 => :environment do
  puts "Getting unfollowers..."
  u = User.where(:waitlist => false)
  i = (u.count/4).to_i
  n = u.to(i)
  n.each do |user|
    user.get_unfollowers
  end
  puts "Finished Batch 1."
end

# Daily task run with Heroku Scheduler
# Batch 2 - other 25% of active users
# Time set to 14:30 UTC
desc "Get unfollowers (Batch 2)"
task :get_unfollowers_b2 => :environment do
  puts "Getting unfollowers..."
  u = User.where(:waitlist => false)
  i = (u.count/4).to_i
  n = u.from(i+1)
  n.each do |user|
    user.get_unfollowers
  end
  puts "Finished Batch 2."
end

# Daily task run with Heroku Scheduler
# Batch 3 - other 25% of active users
# Time set to 14:30 UTC
desc "Get unfollowers (Batch 3)"
task :get_unfollowers_b3 => :environment do
  puts "Getting unfollowers..."
  u = User.where(:waitlist => false)
  i = (u.count/4).to_i
  n = u.from(i+2)
  n.each do |user|
    user.get_unfollowers
  end
  puts "Finished Batch 3."
end

# Daily task run with Heroku Scheduler
# Batch 4 - other 25% of active users
# Time set to 14:30 UTC
desc "Get unfollowers (Batch 4)"
task :get_unfollowers_b4 => :environment do
  puts "Getting unfollowers..."
  u = User.where(:waitlist => false)
  i = (u.count/4).to_i
  n = u.from(i+3)
  n.each do |user|
    user.get_unfollowers
  end
  puts "Finished Batch 4."
end

# You can pass in a single user_id
# e.g. rake release_the_kraken id=50c01482074bff028700001a
desc "Welcome a new user to Mallow"
task :release_the_kraken => :environment do
  puts "Adding to new users..."
  id = ENV['id']
  u = User.find("#{id}")
  u.welcome_new_user
  puts "Finished adding new users."
end
