3.times do
    user = User.create(name: Faker::FunnyName.name, email: Faker::Internet.email, password: Faker::Internet.password)
    3.times do
        user.herbs.create(
            name: Faker::FunnyName.name, 
            latin_name: Faker::FunnyName.name,
            family: Faker::FunnyName.name,
            medicinal_parts: Faker::Lorem.sentence,
            taste: Faker::Lorem.sentence,
            energetics: Faker::Lorem.sentence,
            actions: Faker::Lorem.paragraph,
            ideal_for: Faker::Lorem.paragraph,
            applications: Faker::Lorem.paragraph,
            dosage: Faker::Lorem.paragraph,
            considerations: Faker::Lorem.paragraph
            )
    end
end