# Friend Book

A social media site with the main functionality of Facebook (users, profiles, “friending”, posts, news feed, and “liking”).

Developed as the final project in the Ruby on Rails section of [The Odin Project](https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project).

## Demo App

You can view this [web app](https://friendbook.fly.dev/users/sign_in) on Fly.

If you would like to create friendships or generate notifications by liking/commenting, you may log in as any of the sample users.

Sample usernames:
`Fiona` | `Maybe` | `Charles76` | `Gerald`

Password: `HelloWorld`

![Short demo of Friendbook](demo.gif)

## Features

- Sign-in
  - account creation is handled with Devise
  - users can also sign-in with their Facebook account via OmniAuth
  - new users are sent a welcome email
- Post
  - users can create and delete posts
  - posts can have many likes and comments
  - a user's feed shows them their own posts and those by their friends
- Comment
  - users can create and delete comments
  - users can reply to others (nested comments)
  - comments can have many likes
- Notification
  - can take many forms (polymorphic)
  - notified when a reply is made to a user's comment
  - notified when a comment is made on a user's post
  - notified when a post or comment receives a like
  - notified when friendships are requested and accepted
- Reaction
  - can take many forms (polymorphic)
  - users can like/unlike a comment
  - users can like/unlike a post
- Profile
  - users can add/edit their full name, age, location, and bio
- Friendship
  - utilized relation queries so that only 1 database record is created for each friendship
  - users can send + decline friend requests
  - posts won't show on user's feed until proposed friend accepts the friendship
- Style
  - designed with Bootstrap
  - responsive layout
- Testing
  - Rspec/Capybara
  - 94% coverage

## Personal Lessons and Reflections

### Infinite Scroll

I really wanted to implement an infinite scroll for my post index views to more closely resemble the user experience on Facebook. I
followed [this tutorial](https://www.colby.so/posts/infinite-scroll-with-turbo-streams-and-stimulus) and found it to be a really cool use of turbo streams.

### Fixing N+1 Issues

It was very important to me that I address any n+1 issues as best I could to improve performance. After researching, I utilized the [bullet](https://github.com/flyerhzm/bullet) and [query_diet](https://github.com/makandra/query_diet) gems to
help identify places where eager loading was needed. I also added counter caches to my database so that I could easily
query the number of comments and likes for each post.

### Testing

I got really into testing on this project (the thrill of an all-green test suite is unbeatable!). I already had familiarity
with Rspec testing for Ruby, but did a lot of research to understand how that applied to Rails and what aspects of a Rails app
were important to test. I used the [SimpleCov](https://github.com/simplecov-ruby/simplecov) gem to track and figure out my testing coverage.

### Turbo Frames / Stimulus

The magic of turbo frames and stimulus cannot be overstated! It was fun to figure out the best use for them within the app to
allow for a more seamless user experience (a user being able to edit their info directly in their profile view rather than being navigated away) and better app performance (lazy loading modals after they're clicked).

## Local Installation

To run locally, you must have the following prerequisites:

```
Ruby >= 3.1.2
Rails >= 7.0.4
Bundler >= 2.3.14
```

- Clone this repo
- Navigate into this project's directory `cd odin-facebook`
- Install the required gems, by running `bundle install`
- This app uses [figaro](https://github.com/laserlemon/figaro) to manage secrets. You will need to create your own secrets for [facebook](https://developers.facebook.com/docs/development#register), and [gmail](https://guides.rubyonrails.org/action_mailer_basics.html#action-mailer-configuration-for-gmail).
- Create and seed the database, by running `rails db:setup`
- Start the local server, by running `bin/dev`
- View by visiting `localhost:3000` in a web browser

## Running the tests

- To run the entire test suite: `rspec`
- You can specify one spec folder to run a group of tests, such as: `rspec spec/system`
- You can specify one spec folder to run a single set of tests, such as: `rspec spec/models/notification_spec.rb`

## Contact

Anna Sampers - [LinkedIn](https://linkedin.com/in/anna-sampers) - annasampers@gmail.com
