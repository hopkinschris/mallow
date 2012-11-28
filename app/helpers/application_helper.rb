module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  # Can return four different sizes from Twitter API
  # :original - size is undefined, whatever user uploaded
  # :mini - 24px by 24px
  # :normal - 48px by 48px
  # :bigger - 73px by 73px
  def mailer_unfollower_details(size, id, options={})
    if options[:style]
      style = options[:style]
    end
    src = Twitter.user(id).profile_image_url(size)
    name = Twitter.user(id).name
    handle = '@' + Twitter.user(id).screen_name
    user_followers = Twitter.follower_ids(@user.uid.to_i).collection
    unfollower_status =
      if user_followers.include?(id)
        content_tag(:span, "Following", :class => 'status', :style => "font-size:8px;color:#777;padding:2px 5px;margin-top:2px;text-transform:uppercase;background-color:#EEE;border-radius:3px;")
      end
    details = 
      content_tag(:li, name, :class => 'name', :style => "list-style:none;font-weight:500;color:#444;") +
      content_tag(:li, handle, :class => 'handle', :style => "list-style:none;color:#999;font-weight:300;margin-bottom:4px;") +
      unfollower_status
    content_tag(:img, nil, :src => src, :class => 'avatar', :style => style) +
    content_tag(:ul, details, :style => "padding:0;margin:0 2.5em 0 0;float:right;")
  end

  def mailer_unfollower_link(id, options={})
    link_to mailer_unfollower_details(:normal, id, options), "http://twitter.com/#{Twitter.user(id).screen_name}", :target => '_blank', :style => "display:inline-block;text-decoration:none;"
  end

  # Can return four different sizes from Twitter API
  # :original - size is undefined, whatever user uploaded
  # :mini - 24px by 24px
  # :normal - 48px by 48px
  # :bigger - 73px by 73px
  def unfollower_details(size, id)
    src = Twitter.user(id).profile_image_url(size)
    name = Twitter.user(id).name
    handle = '@' + Twitter.user(id).screen_name
    current_user_followers = Twitter.follower_ids(current_user.uid.to_i).collection
    unfollower_status =
      if current_user_followers.include?(id)
        content_tag(:span, "Following", :class => 'status')
      end
    details =
      content_tag(:span, name, :class => 'name') +
      content_tag(:span, handle, :class => 'handle') +
      unfollower_status
    content_tag(:img, nil, :src => src, :class => 'avatar') +
    content_tag(:div, details)
  end

  def unfollower_link(id)
    link_to unfollower_details(:normal, id), "http://twitter.com/#{Twitter.user(id).screen_name}", :target => '_blank'
  end

end
