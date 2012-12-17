# Daily task run with Heroku Scheduler
# Time set to 14:00 UTC
desc "Get unfollowers"
task :get_unfollowers => :environment do
  puts "Getting unfollowers..."
  task_count = 0
  User.all.each do |u|
    u.get_unfollowers
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
