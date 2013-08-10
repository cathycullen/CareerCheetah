require 'csv'

def import_onet_data
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

  # Sections & Questions
  print "\tCreating sections..."
  phase = Phase.where(:name => "Phase One").first
  section_data = YAML.load_file(File.join(Rails.root, "db/seed_data/section_questions.yml"))
  section_data['sections'].each do |section_data|
    section = phase.sections.create!(:name => section_data['name'],
                                     :headline => section_data['headline'],
                                     :description => section_data['description'])


    section_data['questions'].each do |question_data|
      question = section.questions.create!(:prompt => question_data['prompt'])
      question_data['responses'].each do |response_data|
        question.response_options.create(:description => response_data['description'],
                                         :factor => Factor.find_by(:element_code => response_data['element_code']))
      end
    end
  end
  puts "done"
end

import_onet_data
generate_sample_users
generate_sample_quiz_data
