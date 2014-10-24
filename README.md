# Mallow

Get mail about who unfollowed you on Twitter.

## Instructions

1. Provide the following env variables in `config/mallowapp.rb`: `TWITTER_KEY`, `TWITTER_SECRET`, `TWITTER_OAUTH_TOKEN`, `TWITTER_OAUTH_TOKEN_SECRET`, `ADMIN_EMAIL`, and `ADMIN_TWITTER`.

2. Replace all instances of `@foobar` with your own Twitter username.

3. Deploy to Heroku.

4. Setup Heroku add-ons for MongoHQ, RedisToGo, and SendGrid.

5. Once all your services on Heroku are properly setup then you can setup Heroku Scheduler to run `rake get_unfollowers_b1` and so on to run daily.

## Features

### Admin Dashboard

The app comes with a full administration dashboard where you can activate user accounts that have requested access. You can also see the number of active users, mails sent and user's waiting for their account to be activated.

### Auto Magic Mailer

The app will mail users every 24 users with a list of their unfollowers from Twitter.

### Feedback Form

There is an always accessible feedback form that will take the message the user and send them to the Admin.

## Authors

Christopher Hopkins

  * [http://twitter.com/hopkinschris](http://twitter.com/hopkinschris)
  * [http://github.com/hopkinschris](http://github.com/hopkinschris)

## License

You may use Mallowapp under the terms of the [MIT License](https://github.com/hopkinschris/mallow/blob/master/LICENSE).
