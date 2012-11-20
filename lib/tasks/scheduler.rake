desc "Get unfollowers"
task :get_unfollowers => :environment do
  puts "Getting unfollowers..."
  User.all.each do |u|
    u.get_unfollowers
  end
  puts "Finished."
end
