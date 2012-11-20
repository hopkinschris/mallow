every 1.day, :at => '9:00 am' do
  runner "User.all.each{ |u| u.get_unfollowers }"
end
