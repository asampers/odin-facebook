namespace :db do
  desc "Populates the database with sample data"
  task populate_sample_data: :environment do
    Devise::Mailer.perform_deliveries = false

    fiona = User.find_or_create_by(username: "Fiona", email: "fiona@fiona.com") do |user|
      user.password = "HelloWorld"
    end

    maybe = User.find_or_create_by(username: "Maybe", email: "maybe@maybe.com") do |user|
      user.password = "HelloWorld"
    end 

    charles = User.find_or_create_by(username: "Charles76", email: "charles@charles.com") do |user|
      user.password = "HelloWorld"
    end 

    gerald = User.find_or_create_by(username: "Gerald", email: "gerald@gerald.com") do |user|
      user.password = "HelloWorld"
    end  

    sugarbear = User.find_or_create_by(username: "Sugar Bear", email: "sugarbear@sugarbear.com") do |user|
      user.password = "HelloWorld"
    end 

    oskar = User.find_or_create_by(username: "Oskar", email: "oskar@oskar.com") do |user|
      user.password = "HelloWorld"
    end 

    all_smiles = User.find_or_create_by(username: "All_smiles", email: "allsmiles@allsmiles.com") do |user|
      user.password = "HelloWorld"
    end 

    trudy = User.find_or_create_by(username: "Trudy", email: "trudy@trudy.com") do |user|
      user.password = "HelloWorld"
    end 

    felix = User.find_or_create_by(username: "Felix", email: "felix@felix.com") do |user|
      user.password = "HelloWorld"
    end 

    flower_power = User.find_or_create_by(username: "Flower Power", email: "flowerpower@flowerpower.com") do |user|
      user.password = "HelloWorld"
    end  

    Devise::Mailer.perform_deliveries = true

    users = [fiona, maybe, charles, gerald, sugarbear, oskar, all_smiles, trudy, felix, flower_power]

    #create sample friendships
    users.repeated_combination(2).to_a.each_with_index do |pair, index|
      next if pair[0] == pair[1]
      
      if (index%2).zero?
        request = Friendship.find_or_create_by(user_id: pair[0].id, friend_id: pair[1].id)
        request.update(status: "accepted")
      else 
        request = Friendship.find_or_create_by(user_id: pair[0].id, friend_id: pair[1].id)
      end 
    end 

    #create sample posts, comments, likes, and notifications
    whale = Post.find_or_create_by(user: fiona, body: " Willy and I didn't get off to a very good start. 
        He thinks I'm the Wicked Witch or something cause of all the medical tests I had to do on him.")
      parent = Comment.find_or_create_by(user: charles, post: whale, body: "You know out in the ocean, killer whales like Willy 
        live in families. Pods. Some of them spent their whole lives with their moms and they never leave them.")
      reply = Comment.find_or_create_by(user: felix, post: whale, body: "Never?", parent: parent)
      social = Comment.find_or_create_by(user: all_smiles, post: whale, body: "Their social structure's really important to them. 
        Over fifty orcas have been seen traveling together. Some of them stayed together forever for their whole lives")
      Notification.find_or_create_by(user: fiona, notifiable: parent, sender: charles)
      Notification.find_or_create_by(user: fiona, notifiable: social, sender: all_smiles)
      Notification.find_or_create_by(user: charles, notifiable: reply, sender: felix)
      
      one = Reaction.find_or_create_by(user: sugarbear, reactable: parent)
      two = Reaction.find_or_create_by(user: all_smiles, reactable: reply)
      three = Reaction.find_or_create_by(user: felix, reactable: whale)
      
      Notification.find_or_create_by(user: charles, notifiable: one, sender: sugarbear)
      Notification.find_or_create_by(user: felix, notifiable: two, sender: all_smiles)
      Notification.find_or_create_by(user: fiona, notifiable: three, sender: felix)

    muppet = Post.find_or_create_by(user: maybe, body: "I don't care what you think of me, unless you think I'm awesome. In which case you are right.")
      nice = Comment.find_or_create_by(user: oskar, post: muppet, body: "It's nice to be important, but it's important to be nice :)")
      four = Reaction.find_or_create_by(user: trudy, reactable: muppet)
      five = Reaction.find_or_create_by(user: gerald, reactable: muppet)
      Notification.find_or_create_by(user: maybe, notifiable: four, sender: trudy)
      Notification.find_or_create_by(user: maybe, notifiable: nice, sender: oskar)

    dream = Post.find_or_create_by(user: charles, body: "I had the craziest dream last night. I was riding an elephant and it started to fly
      and asked me if I'd done all my homework. Not sure what that means...")
      six = Reaction.find_or_create_by(user: flower_power, reactable: dream)
      Notification.find_or_create_by(user: charles, notifiable: six, sender: flower_power)

    powder = Post.find_or_create_by(user: gerald, body: "It has become appallingly clear that our technology has surpassed our humanity.")  
      albert = Comment.find_or_create_by(user: sugarbear, post: powder, body: "Albert Einstein.")
      surpass = Comment.find_or_create_by(user: gerald, post: powder, parent: albert, body: "When I look at you, I have hope that maybe one day our humanity will surpass our technology.")
      seven = Reaction.find_or_create_by(user: all_smiles, reactable: surpass)
      Notification.find_or_create_by(user: gerald, notifiable: albert, sender: sugarbear)
      Notification.find_or_create_by(user: gerald, notifiable: seven, sender: all_smiles)

    sonora = Post.find_or_create_by(user: sugarbear, body: "I found my destiny, not in far off places but within myself.")
      hair = Comment.find_or_create_by(user: fiona, post: sonora, body: "You poor thing. Who does your hair?")
      well = Comment.find_or_create_by(user: sugarbear, post: sonora, parent: hair, body: "Well, I do.")
      careful = Comment.find_or_create_by(user: felix, post: sonora, parent: well, body: "you have to be extremely careful 
        with your appearance. I mean, having no natural beauty of your own you really need to help yourself")
      Reaction.find_or_create_by(user: felix, reactable: hair)

    jurassic = Post.find_or_create_by(user: oskar, body: "All major theme parks have delays. When they opened Disneyland in 1956, nothing worked!")
      yeah = Comment.find_or_create_by(user: maybe, post: jurassic, body: "Yeah, but, if The Pirates of the Caribbean breaks down, the pirates don't eat the tourists.")
      Reaction.find_or_create_by(user: charles, reactable: yeah)
      Reaction.find_or_create_by(user: trudy, reactable: jurassic)
      Reaction.find_or_create_by(user: charles, reactable: jurassic)

    happy = Post.find_or_create_by(user: all_smiles, body: "If you're happy and you know it, clap your hands!")
      Comment.find_or_create_by(user: sugarbear, post: happy, body: "Clap!!")
      Comment.find_or_create_by(user: flower_power, post: happy, body: "CLAP CLAP")
      
    titanic = Post.find_or_create_by(user: trudy, body: "Did you know, in the 1997 classic 'Titanic', at around the 53 min mark, 
      when Jack and Rose are talking about going to the Santa Monica Pier, Jack says that they will 'ride on the roller coaster 
      until we throw up' but the roller coaster was not built until 1916.")
      Comment.find_or_create_by(user: oskar, post: titanic, body: "now i do")  

    cat = Post.find_or_create_by(user: felix, body: "CAT FACTS: Cats can jump 5 times their own height. Now that's impressive!")

    rain = Post.find_or_create_by(user: flower_power, body: "Whenever you can, go out into the rain! Do NOT miss the opportunity!!!")
      Reaction.find_or_create_by(user: charles, reactable: rain)
      Reaction.find_or_create_by(user: oskar, reactable: rain)
      Reaction.find_or_create_by(user: all_smiles, reactable: rain)
  end
end
