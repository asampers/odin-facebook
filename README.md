# Friend Book

A social media site with the main functionality of Facebook (users, profiles, “friending”, posts, news feed, and “liking”).

Developed as the final project in the Ruby on Rails section of [The Odin Project](https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project).

## Demo App
You can view this [web app](https://friendbook.fly.dev/users/sign_in) on Fly.

If you would like to create friendships or generate notifications by liking/commenting, you may log in as any of the sample users. 

Sample usernames:
`Fiona`   |   `Maybe`   

Password: `111111`

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
  - users can reply to others (nested comments)
  - comments can have many likes
- Notification
  - can take many forms (polymorphic)
  - notified when a reply is made to a user's comment
  - notified when a comment is made on a user's post
  - notified when a post or comment recieves a like
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
- Style
  - designed with Bootstrap
  - responsive layout
- Testing
  - Rspec/Capybara
  - 94% coverage

## Personal Lessons and Reflections (!elaborate!)
- [Infinite scroll](https://www.colby.so/posts/infinite-scroll-with-turbo-streams-and-stimulus)
- n+1 issues
- testing coverage
- turbo frames wherever possible
- stimulus to make modals load when clicked 
- had so much fun!

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
- To run the entire test suite `rspec`
- You can specify one spec folder to run a group of tests, such as `rspec spec/system`
- You can specify one spec folder to run a single set of tests, such as `rspec spec/models/notification_spec.rb`

## Contact
Anna Sampers - [LinkedIn](https://linkedin.com/in/anna-sampers) - annasampers@gmail.com
