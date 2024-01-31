# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


10.times do |i|
    User.create(
        name: Faker::Name.name_with_middle,
        email: Faker::Internet.email,
        password: 'password@123',
        city: Faker::Address.city,
        state: Faker::Address.state,
        country: 'PK',
        contact_number: Faker::PhoneNumber.cell_phone_with_country_code
    )
end


['HTML', 'CSS3', 'React JS', 'Bootstrap', 'Angular' ].each do |skill_name|
    FrontEndSkill.find_or_create_by(name: skill_name)
end

['Ruby', 'Python', 'Java', 'Node JS']. each do |skill_name|
    BackEndSkill.find_or_create_by(name: skill_name)
end

(1..5).each do |x|
    UserSkill.create(user: User.find(x), skill: Skill.find(x))
    UserSkill.create(user: User.find(x), skill: Skill.find(x))
    UserSkill.create(user: User.find(x), skill: Skill.find(x))
end