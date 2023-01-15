task sample_data: :environment do
  p "Creating sample data"

  if Rails.env.development?
    Like.destroy_all
    Comment.destroy_all
    FollowRequest.destroy_all  
    Photo.destroy_all
    User.destroy_all
  end

  usernames = Array.new{Faker::Name.first_name}
  10.times do
    this_name = Faker::Name.first_name
    usernames << this_name
  end
  usernames << "alice"
  usernames << "bob"
  usernames.each do |username|
    User.create(
      email: "#{username}@example.com",
      username: username.downcase,
      password: "password",
      private: [true,false].sample
    )
  end
  p "#{User.count} users have been created."

  all_users = User.all

  #FollowRequests
  all_users.each do |user1|
    all_users.each do |user2|
       if rand < 0.5 && user1 != user2
        user1.sent_follow_requests.create(
          recipient: user2,
          status: FollowRequest.statuses.keys.sample 
          #keys or values
        )
      end

      
    end
  end

  p "#{FollowRequest.count} follow requests have been created."

  #Photos
  all_users.each do |user|
    creating = rand(4)
    creating.times do
      text_cap = Faker::Quote.yoda 
      photo = user.own_photos.create(
        image: "https://robohash.org/#{rand(9999)}",
        caption: text_cap
      )

      #Comments and Likes
      user.followers.each do |follower|
        #Likes
        if rand < 0.6
          photo.fans << follower
        end

        #Comment:
        if rand < 0.3
          text_comment = Faker::TvShows::HowIMetYourMother.quote
          photo.comments.create(
            body: text_comment, 
            author: follower
          )
        end
      end

    end
  end

  p "#{Photo.count} photos have been created."
  p "#{Like.count} likes have been created."
  p "#{Comment.count} likes have been created."

end
