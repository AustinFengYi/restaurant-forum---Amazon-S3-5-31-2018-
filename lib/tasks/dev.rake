namespace :dev do
  task fake_restaurant: :environment do
    Restaurant.destroy_all

    500.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample,
        image: File.open("#{Rails.root}/public/img/#{rand(1..9)}.jpg")

      )
    end
    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"
  end

  task fake_user: :environment do
      User.destroy_all
      20.times do |i|
        user_name = FFaker::Name.first_name
        User.create!(
          email: "#{user_name}@example.com",
          password: "12345678",
          image: File.open("#{Rails.root}/public/img/profile/#{rand(1..6)}.jpg")
        )
      end
    puts "have created fake users"
    puts "now you have #{User.count} users data"
  end


  task fake_comment: :environment do
    Comment.destroy_all

    Restaurant.all.each do |restaurant|
      3.times do |i|
        restaurant.comments.create!(
          content: FFaker::Lorem.sentence,
          user: User.all.sample
        )
      end
    end
    puts "have created fake comments"
    puts "now you have #{Comment.count} comment data"
  end

  # fake comment
  task fake_favorite: :environment do
    Favorite.destroy_all

    @restaurants = Restaurant.all
    @users = User.all 

      100.times do |i|
        Favorite.create!(
          user_id: @users.sample.id,
          restaurant_id: @restaurants.sample.id,
          )
      end

    puts "have created fake 100 favorites data."
    puts "now you have #{Favorite.count} Favorites data"
  end

end