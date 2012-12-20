# Daily task run with Heroku Scheduler
# Batch 1 - 50% of active users
# Time set to 13:00 UTC
desc "Get unfollowers (Batch 1)"
task :get_unfollowers_b1 => :environment do
  puts "Getting unfollowers..."
  u = User.where(:waitlist => false)
  i = (u.count/2).to_i
  n = u.to(i)
  task_count = 0
  n.each do |user|
    user.get_unfollowers
    task_count += 1
  end
  @count = task_count.to_s
  FeedbackMailer.task_mail(@count).deliver
  puts "Finished."
end

# Daily task run with Heroku Scheduler
# Batch 2 - other 50% of active users
# Time set to 14:30 UTC
desc "Get unfollowers (Batch 2)"
task :get_unfollowers_b2 => :environment do
  puts "Getting unfollowers..."
  u = User.where(:waitlist => false)
  i = (u.count/2).to_i
  n = u.from(i+1)
  task_count = 0
  n.each do |user|
    user.get_unfollowers
    task_count += 1
  end
  @count = task_count.to_s
  FeedbackMailer.task_mail(@count).deliver
  puts "Finished."
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
