require 'csv'

# Create sample users
3.times do
  User.create!(:email => Faker::Internet.email,
               :name => Faker::Name.first_name + " " + Faker::Name.last_name,
               :password => "careerC33tah",
               :password_confirmation => "careerC33tah")
end

# Factors
#
## Classes
category = FactorCategory.where(:name => "Classes").first_or_create
CSV.foreach(File.join(Rails.root, "db/seed_data/classes.csv")) do |row|
  Factor.create!(:description => row[1], :onet_code => row[0], :factor_category => category)
end
