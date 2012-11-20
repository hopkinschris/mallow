module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  # Can return four different sizes from Twitter API
  # :original - size is undefined, whatever user uploaded
  # :mini - 24px by 24px
  # :normal - 48px by 48px
  # :bigger - 73px by 73px
  def unfollower_avatar(size, id)
    src = Twitter.user(id).profile_image_url(size)
    content_tag :img, nil, :src => src, :class => 'avatar'
  end

  def unfollower_link(id)
    link_to unfollower_avatar(:normal, id), "http://twitter.com/#{Twitter.user(id).screen_name}", :target => '_blank'
  end

end
