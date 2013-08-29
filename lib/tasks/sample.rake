require 'csv'

namespace :sample do
  desc "Remove existing example users then insert sample used based on the CSVs in db/seed_data"
  task :users => :environment do
    puts "Generating sample users..."
    users = ["christine", "adam", "kelly", "rob", "chris"]

    # Destroy existing sample users
    users.each do |name|
      u = User.find_by(:email => "#{name}@abc.com")
      u.destroy if u
    end

    # Create new sample users
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

  desc "Regenerate the default program questionnaire"
  task :questionnaire => :environment do
    puts "Generating sample quiz data..."

    p = Program.find_by(:name => "Career Cheetah Default")
    p.destroy if p

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
                                       :description => section_data['description'],
                                       :code => section_data['code'])
      if section_data['steps']
        section_data['steps'].each do |step_data|
          step_options = {:template => step_data['template_name'],
                          :headline => step_data['headline'],
                          :description => step_data['description']}

          if step_data['step_type'] == "Question"
            question = Question.create!(:prompt => step_data['prompt'],
                                        :prompt_type => step_data['type'],
                                        :description => step_data['description'],
                                        :headline => step_data['headline'])
            if step_data['responses']
              step_data['responses'].each do |response_data|
                question.response_options.create!(:description => response_data['description'],
                                                  :factor => Factor.find_by(:element_code => response_data['element_code']),
                                                  :fit_code => response_data['fit_code'],
                                                  :description => response_data['description'],
                                                  :rating_prompt => response_data['rating_prompt'],
                                                  :work_zone => response_data['work_zone'],
                                                  :response_type => response_data['type'])
              end
            end

            section.section_steps.create!(step_options.merge(:type => "QuestionStep", :question => question))
          elsif step_data['step_type'] == "Static"
            section.section_steps.create!(step_options.merge(:type => "StaticStep"))
          elsif step_data['step_type'] == "ResponseDistributionStep"
            section.section_steps.create!(step_options.merge(:type => "ResponseDistributionStep"))
          end
        end
      end
      section.section_steps.create!(:type => "ConclusionStep") if section.name != "Hunting Solo"
    end
    puts "done"
  end
end
