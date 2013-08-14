require 'csv'

puts "Importing ONet data..."
print "\tImporting factors..."
# Factors
CSV.foreach(File.join(Rails.root, "db/seed_data/onet_factors.csv")) do |row|
  Factor.create!(:element_code => row[0],
                 :name => row[1],
                 :description => row[2] )
end
puts "done"

# Careers
print "\tImporting careers..."
CSV.foreach(File.join(Rails.root, "db/seed_data/careers.csv")) do |row|
  Career.create!(:onet_code => row[0],
                 :title => row[1],
                 :description => row[2],
                 :job_zone => row[3],)
end
puts "done"

print "\tImporting career/factor mappings..."
# CareerFactorMappings
CSV.foreach(File.join(Rails.root, "db/seed_data/career_factors.csv")) do |row|
  career = Career.where(:onet_code => row[1]).first
  factor = Factor.where(:element_code => row[0]).first
  CareerFactorMapping.create!(:factor => factor,
                               :career => career,
                               :weight => row[2])
end
puts "done"

User.create!(:email => "test@careercheetah.net",
             :name => "Test User",
             :password => "careerC33tah",
             :password_confirmation => "careerC33tah")
