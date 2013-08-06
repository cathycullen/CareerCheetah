require 'csv'

def import_onet_data
  puts "Importing ONet data..."

  print "\tImporting factors..."
  # Factors
  CSV.foreach(File.join(Rails.root, "db/seed_data/onet_factors.csv")) do |row|
    Factor.create!( :element_code => row[0], :name => row[1], :description => row[2] )
  end
  puts "done"

  # Careers
  print "\tImporting careers..."
  CSV.foreach(File.join(Rails.root, "db/seed_data/careers.csv")) do |row|
    Career.create!( :onet_code => row[0], :title => row[1], :description => row[2], :job_zone => row[3],)
  end
  puts "done"

  print "\tImporting career/factor mappings..."
  # CareerFactorMappings
  CSV.foreach(File.join(Rails.root, "db/seed_data/career_factors.csv")) do |row|
    career = Career.where(:onet_code => row[1]).first
    factor = Factor.where(:element_code => row[0]).first
    CareerFactorMapping.create!( :factor => factor, :career => career, :weight => row[2])
  end
  puts "done"
end

def generate_sample_users
  puts "Generating sample users..."

  print "\tCreating sample users..."
  # Create sample users
  3.times do
    User.create!(:email => Faker::Internet.email,
                 :name => Faker::Name.first_name + " " + Faker::Name.last_name,
                 :password => "careerC33tah",
                 :password_confirmation => "careerC33tah")
  end
  puts "done"

  print "\tCreating factor selections for users..."
  # FactorSelections
  User.all.each do |user|
    selected_factors = Factor.all.to_a.shuffle.first(rand(5)+1)
    selected_factors.each do |f|
      user.factor_selections.create!(:factor => f)
    end
  end
  puts "done"
end

def generate_sample_quiz_data
  puts "Generating sample quiz data..."

  # Programs
  print "\tCreating sample program..."
  default_program = Program.create!(:name => "Career Cheetah Default")
  puts "done"

  # Phases
  print "\tCreating phases..."
  ["Phase One", "Phase Two"].each do |name|
    phase = Phase.create!(:name => name)
    # ProgramPhases
    default_program.program_phase_mappings.create(:phase => phase)
  end
  puts "done"

  # Sections
  print "\tCreating sections..."
  phase = Phase.where(:name => "Phase One").first
  ["Moods", "Obstacles", "Action Steps", "Classes", "Fit", "Environment"].each do |name|
    section = Section.create!(:name => name)
    phase.phase_section_mappings.create!(:section => section)
  end
  puts "done"
end

import_onet_data
generate_sample_users
generate_sample_quiz_data
