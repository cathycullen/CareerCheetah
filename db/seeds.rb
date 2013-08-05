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
category = FactorCategory.where(:name => "Classes").first_or_create
CSV.foreach(File.join(Rails.root, "db/seed_data/classes.csv")) do |row|
  Factor.create!(:description => row[1], :onet_code => row[0], :factor_category => category)
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
