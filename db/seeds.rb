require 'csv'

# Prediction Models
#

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
CSV.foreach(File.join(Rails.root, "db/seed_data/classes.csv")) do |row|
  Factor.create!(:description => row[1], :element_code => row[0])
end

# FactorSelections
User.all.each do |user|
  selected_factors = Factor.all.to_a.shuffle.first(rand(5)+1)
  selected_factors.each do |f|
    user.factor_selections.create!(:factor => f)
  end
end

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
  Career.create!( :onet_code => row[0],  :title => row[1],:description => row[2],  :job_zone => row[3],)
end


# CareerFactors
CSV.foreach(File.join(Rails.root, "db/seed_data/career_factors.csv")) do |row|
	career = Career.where(:onet_code => row[1]).first
	factor = Factor.where(:element_code => row[0]).first
	if factor
		CareerFactorMapping.create!( :factor => factor, :career => career, :weight => row[2])
	end
end

