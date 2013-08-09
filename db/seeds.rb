require 'csv'

# Prediction Models
#

# Create sample users
#3.times do
#  User.create!(:email => Faker::Internet.email,
#               :name => Faker::Name.first_name + " " + Faker::Name.last_name,
#               :password => "careerC33tah",
#               :password_confirmation => "careerC33tah")


users = ["christine", "adam", "kelly", "rob", "chris"]
User.all.destroy_all

users.each do |u|
  user = User.create!(:email => "#{u}@abc.com",
	           :name => u,
               :password => "careerC33tah",
               :password_confirmation => "careerC33tah")	
    CSV.foreach(File.join(Rails.root, "db/seed_data/#{u}.csv")) do |row|
	  factor = Factor.where(:element_code => row[0].strip).first
       puts "#{u} - #{row[0]}  factor #{factor.id}"
     user.factor_selections.create!(:factor => factor)
    end
end




# Factors
#

CSV.foreach(File.join(Rails.root, "db/seed_data/onet_factors.csv")) do |row|
  Factor.create!( :element_code => row[0], :name => row[1], :description => row[2] )
end

# FactorSelections
# User.all.each do |user|
#   selected_factors = Factor.all.to_a.shuffle.first(rand(10)+1)
#   selected_factors.each do |f|
#     user.factor_selections.create!(:factor => f)
#   end
# end

# Inquiry Models
#

# Programs
default_program = Program.create!(:name => "Career Cheetah Default")

# Phases
["Phase One", "Phase Two"].each do |name|
  phase = Phase.create!(:name => name)
  # ProgramPhases
  default_program.program_phase_mappings.create(:phase => phase)
end

# Sections
phase = Phase.where(:name => "Phase One").first
["Moods", "Obstacles", "Action Steps", "Classes", "Fit", "Environment"].each do |name|
  section = Section.create!(:name => name)
  phase.phase_section_mappings.create!(:section => section)
end


# Careers
CSV.foreach(File.join(Rails.root, "db/seed_data/careers.csv")) do |row|
  Career.create!( :onet_code => row[0], :title => row[1], :description => row[2], :job_zone => row[3],)
end

# CareerFactorMappings
CSV.foreach(File.join(Rails.root, "db/seed_data/career_factors.csv")) do |row|
	career = Career.where(:onet_code => row[1]).first
	factor = Factor.where(:element_code => row[0]).first
	CareerFactorMapping.create!( :factor => factor, :career => career, :weight => row[2])
end


