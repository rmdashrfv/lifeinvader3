## Setup

1. uncomment the redis gem in your Gemfile
2. Make sure redis installed
3. Make sure redis is running
   ```
   # mac
   brew services start redis

   # WSL
   redis-server
   ```


### Implementing websockets

1. Generate a channel for subscribers to listen on:

`rails g channel LiveFeed`

2. Tell the LiveFeed channel object what to do when someone
subscribes (and unsubscribes):

```ruby
class LiveFeedChannel < ApplicationCable::Channel
  def subscribed
    stream_from "live_feed"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end
```

3. Mount ActionCable to a path in our `routes.rb`. This gives our clients a way to send an HTTP request to our application to upgrade to Websockets.

`mount ActionCable.server => '/cable'`

4. In `/config/development.rb` add a path for ActionCable.
Make sure the path matches the path you wrote in `routes.rb`.
`config.action_cable.url = "ws://localhost:3000/cable"

4A. You may have to uncomment this line (in development environments)

`  # config.action_cable.disable_request_forgery_protection = true
`

5. Anywhere in your application, you run `ActionCable.server.broadcast` and tell it what channel to broadcast to, and what message data to send:

Most commonly put in Controllers (and Models)
```ruby
ActionCable.server.broadcast('live_feed', {
  post: newly_created_post_object
})
```