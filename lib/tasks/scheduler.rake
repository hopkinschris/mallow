BATCH_SIZE = 5


# Time set to 12:30 UTC
desc "Get unfollowers (Batch 1)"
task :get_unfollowers_b1 => :environment do
  puts "Getting unfollowers..."
  u = User.where(:waitlist => false)
  REDIS.set("pointer", BATCH_SIZE)
  n = u[0...BATCH_SIZE]
  n.each do |user|
    user.get_unfollowers
  end
  puts "Finished Batch 1."
end

# Time set to 13:00 UTC
desc "Get unfollowers (Batch 2)"
task :get_unfollowers_b2 => :environment do
  puts "Getting unfollowers..."
  u = User.where(:waitlist => false)
  i = REDIS.get("pointer").to_i
  k = i + BATCH_SIZE
  n = u[i...k]
  n.each do |user|
    user.get_unfollowers
  end
  REDIS.set("pointer", k)
  puts "Finished Batch 2."
end

# Time set to 13:30 UTC
desc "Get unfollowers (Batch 3)"
task :get_unfollowers_b3 => :environment do
  puts "Getting unfollowers..."
  u = User.where(:waitlist => false)
  i = REDIS.get("pointer").to_i
  k = i + BATCH_SIZE
  n = u[i...k]
  n.each do |user|
    user.get_unfollowers
  end
  REDIS.set("pointer", k)
  puts "Finished Batch 3."
end

# Time set to 14:00 UTC
desc "Get unfollowers (Batch 4)"
task :get_unfollowers_b4 => :environment do
  puts "Getting unfollowers..."
  u = User.where(:waitlist => false)
  i = REDIS.get("pointer").to_i
  k = i + BATCH_SIZE
  n = u[i...k]
  n.each do |user|
    user.get_unfollowers
  end
  REDIS.set("pointer", k)
  puts "Finished Batch 4."
end

# Time set to 14:30 UTC
desc "Get unfollowers (Batch 5)"
task :get_unfollowers_b5 => :environment do
  puts "Getting unfollowers..."
  u = User.where(:waitlist => false)
  i = REDIS.get("pointer").to_i
  n = u[i..-1]
  n.each do |user|
    user.get_unfollowers
  end
  puts "Finished Batch 5."
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
