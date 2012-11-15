class User
  include Mongoid::Document
  field :provider
  field :uid
  field :name
  field :email
  field :nickname
  field :location
  field :waitlist,  :type => Boolean
  field :followers, :type => Array, :default => []

  attr_accessible :provider, 
                  :uid, 
                  :name, 
                  :email, 
                  :nickname, 
                  :location, 
                  :waitlist,
                  :followers

  after_create :get_followers

  def self.create_with_omniauth(auth)
    create! do |user|
      user.waitlist = true
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
         user.nickname = auth['info']['nickname'] || ""
         user.location = auth['info']['location'] || ""
      end
    end
  end

  def get_followers
    self.followers = Twitter.follower_ids(self.nickname).collection
    save
  end

  def fresh_followers
    fresh_followers = Twitter.follower_ids(self.nickname).collection + [657863]
    diff = fresh_followers - self.followers
    diff.each do |id|
      # TODO
      name = Twitter.user(id).screen_name
      puts "#{Twitter.user(name).name}"
    end
  end

end
