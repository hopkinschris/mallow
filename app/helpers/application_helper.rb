module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def flash_class(level)
    case level
    when :notice then "flash"
    when :success then "flash flash-success"
    when :error then "flash flash-error"
    end
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
    handle = '@' + (Twitter.user(id).screen_name).downcase
    cursor = "-1"
    user_followers = []
    while cursor != 0 do
      followers = Twitter.follower_ids(@user.uid.to_i, {:cursor => cursor})
      cursor = followers.next_cursor
      user_followers << followers.ids
      sleep(2)
    end
    user_followers.flatten!
    unfollower_status =
      if user_followers.include?(id)
        content_tag(:span, "You Follow", :class => 'status', :style => "font-size:0.8em;line-height:2em;color:#fff;padding:2px 5px;text-transform:uppercase;background-color:#6cd4ff;border-radius:3px;")
      else
        content_tag(:span, "Don't Follow", :class => 'status', :style => "font-size:0.8em;line-height:2em;color:#777;padding:2px 5px;text-transform:uppercase;background-color:#EEE;border-radius:3px;")
      end
    details = 
      content_tag(:li, handle, :class => 'handle', :style => "line-height:1.3em;-webkit-font-smoothing:antialiased;list-style:none;color:#444;") +
      unfollower_status
    content_tag(:img, nil, :src => src, :class => 'avatar', :style => style) +
    content_tag(:ul, details, :style => "padding:0;margin:0 1em 0 0;vertical-align:top;display:inline-block;")
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
    handle = '@' + (Twitter.user(id).screen_name).downcase
    cursor = "-1"
    current_user_followers = []
    while cursor != 0 do
      followers = Twitter.follower_ids(current_user.uid.to_i, {:cursor => cursor})
      cursor = followers.next_cursor
      current_user_followers << followers.ids
      sleep(2)
    end
    current_user_followers.flatten!
    unfollower_status =
      if current_user_followers.include?(id)
        content_tag(:span, "You Follow", :class => 'status following')
      else
        content_tag(:span, "Don't Follow", :class => 'status')
      end
    details =
      content_tag(:span, handle, :class => 'handle') +
      unfollower_status
    content_tag(:img, nil, :src => src, :class => 'avatar') +
    content_tag(:div, details)
  end

  def unfollower_link(id)
    link_to unfollower_details(:normal, id), "http://twitter.com/#{Twitter.user(id).screen_name}", :target => '_blank'
  end

  def welcome_new_user_btn(user)
    return unless user.waitlist?
    button_to "Activate", :controller => 'admin', :action => 'activate', :user => user
  end

  def active_user_ticker
    ticker = User.where(:waitlist => false).count.to_s + ' ' + 'Users'
    content_tag :li, ticker, :id => 'ticker'
  end

  # Users still on the waitlist
  def inactive_user_ticker
    ticker = User.where(:waitlist => true).count.to_s + ' ' + 'Requests'
    content_tag :li, ticker, :id => 'requests'
  end

  # Users who opted out of the daily email
  def active_user_daily_opt_out_ticker
    ticker = User.where(:waitlist => false, :mail_opt => false).count.to_s + ' ' + 'Opt Outs'
    content_tag :li, ticker, :id => 'opt_outs'
  end

  def admin_stats
    content_tag :ul, (active_user_ticker + active_user_daily_opt_out_ticker + inactive_user_ticker), :class => 'stats'
  end

end
