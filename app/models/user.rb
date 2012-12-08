class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :provider
  field :uid
  field :name
  field :email
  field :nickname
  field :location
  field :waitlist,    :type => Boolean
  field :mail_opt,    :type => Boolean, :default => true
  field :followers,   :type => Array,   :default => []
  field :unfollowers, :type => Array,   :default => []

  attr_accessible :provider, 
                  :uid, 
                  :name, 
                  :email, 
                  :nickname, 
                  :location, 
                  :waitlist,
                  :mail_opt,
                  :followers,
                  :unfollowers

  validates_presence_of   :email, :on => :update, 
                                  :unless => Proc.new { |user| user.email.nil? }

  validates_uniqueness_of :email, :unless => Proc.new { |user| user.email.nil? }

  validates_format_of     :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                                  :unless => Proc.new { |user| user.email.nil? }

  after_create :get_followers

  def self.create_with_omniauth(auth)
    create! do |user|
      user.waitlist = true
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.email = nil
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.nickname = auth['info']['nickname'] || ""
         user.location = auth['info']['location'] || ""
      end
    end
  end

  def get_followers
    self.followers = Twitter.follower_ids(self.nickname).collection
    save
  end

  def welcome_new_user
    self.waitlist = false
    save
    WelcomeMailer.welcome_mail(self).deliver
    puts "Today we welcome #{self.name} to Mallow!"
  end

  def welcome_waitlisted_user
    if self.waitlist?
      WelcomeWaitlistedMailer.welcome_waitlisted_mail(self).deliver
      puts "#{self.name} has requested an invite to Mallow."
    end
  end

  def get_unfollowers
    if self.waitlist? || !self.mail_opt?
      puts "#{self.name} is still on the waitlist or has opted out."
    else
      fresh_followers = Twitter.follower_ids(self.nickname).collection
      diff = self.followers - fresh_followers
      if diff.size > 0
        unfollowers.replace(diff)
        self.followers.replace(fresh_followers)
        save
        UnfollowerMailer.unfollowers_mail(self).deliver
        diff.each do |id|
          name = Twitter.user(id).screen_name
          puts "@#{Twitter.user(name).screen_name} unfollowed #{self.name}."
        end
      else
        unfollowers.clear
        save
        puts "No new unfollowers for #{self.name}."
      end
    end
  end

end
