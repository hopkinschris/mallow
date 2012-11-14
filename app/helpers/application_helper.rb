module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def day_of_the_week
    time = Time.now.strftime("%w")
    case time
      when time = '0'
        content_tag :span, "Sunday"
      when time = '1'
        content_tag :span, "Monday"
      when time = '2'
        content_tag :span, "Tuesday"
      when time = '3'
        content_tag :span, "Wednesday"
      when time = '4'
        content_tag :span, "Thursday"
      when time = '5'
        content_tag :span, "Friday"
      when time = '6'
        content_tag :span, "Saturday"
    end
  end

  def last_follower
    Twitter.follower_ids(current_user.nickname.to_s).collection.last
  end

  def follower_handle
    html = Twitter.user(last_follower).screen_name
    content_tag :span, ('@' + html)
  end

  def follower_legit_score
    followers = Twitter.user(last_follower).follower_count
    friends = Twitter.user(last_follower).friends_count
    score = friends.to_f / followers
    content_tag :span, score.round(2)
  end

  # Can return four different sizes from Twitter API
  # :original - size is undefined, whatever user uploaded
  # :mini - 24px by 24px
  # :normal - 48px by 48px
  # :bigger - 73px by 73px
  def follower_avatar(size)
    src = Twitter.user(last_follower).profile_image_url(size)
    content_tag :img, nil, :src => src, :class => 'avatar'
  end

end
