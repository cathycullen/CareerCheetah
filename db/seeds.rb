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
  User.all.destroy_all

  users = ["christine", "adam", "kelly", "rob", "chris"]
  users.each do |u|
   user = User.create!(:email => "#{u}@abc.com",
                        :name => u,
                        :password => "careerC33tah",
                        :password_confirmation => "careerC33tah")  

    CSV.foreach(File.join(Rails.root, "db/seed_data/#{u}.csv")) do |row|
      factor = Factor.where(:element_code => row[0].strip).first
      user.factor_selections.create!(:factor => factor)
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
    default_program.phases.create!(:name => name)
  end
  puts "done"

  # Sections
  print "\tCreating sections..."
  phase = Phase.where(:name => "Phase One").first
  ["Moods", "Obstacles", "Action Steps", "Classes", "Fit", "Environment"].each do |name|
    phase.sections.create!(:name => name, :headline => Faker::Lorem.sentence(4, false, 2), :description => Faker::Lorem.sentence(7, false, 5))
  end
  puts "done"

  # Questions
  print "\tCreating questions..."
  factors = Factor.all.to_a
  Section.all.each do |section|
    (rand(4)+1).times do
      prompt = Faker::Lorem.sentence(8, false, 4).gsub(/\.$/, "?")
      question = section.questions.create!(:prompt => prompt)
      (rand(12)+1).times do
        factor = (rand(2) == 1) ? factors.sample : nil
        question.response_options.create(:description => Faker::Lorem.sentence(4, false, 5), :factor => factor)
      end
    end
  end
  puts "done"
end

import_onet_data
generate_sample_users
generate_sample_quiz_data
