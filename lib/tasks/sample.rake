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

  desc "Delete existing responses, suggestions, predictions and programs"
  task :wipe_exiting_programs => :environment do
    print "Deleting all exisitng response option selections..."
    ResponseOptionSelection.destroy_all
    CareerSuggestion.destroy_all
    puts "done"
    print "Deleting exiting programs..."
    Program.destroy_all
    puts "done"
  end

  desc "Load questionnaire (program, sections, steps, etc"
  task :load_questionnaire, [:program_name] => :environment do |t, args|
    puts "Loading questionnaire data..."
    program_data = YAML.load_file(File.join(Rails.root, "db/seed_data", args.program_name + ".yml"))
    program = Program.create!(:name => program_data['name'])
    QuestionnaireImporter.import_phases(program, program_data)
  end

  desc "Sample user with a sample CheetahFactors (custom and non-custom)"
  task :rating_user => :environment do
    puts "Generating sample user..."
    user = User.create!(email: "rating@example.com", name: "Rating User", password: "password", password_confirmation: "password")

    c = user.user_careers.rank(:row_order)[0]
    c.name = "Butcher"
    c.save

    c = user.user_careers.rank(:row_order)[1]
    c.name = "Mechanic"
    c.save

    f = user.custom_cheetah_factors.rank(:row_order)[0]
    f.custom_name = "taking dog to work"
    f.save

    f = user.custom_cheetah_factors.rank(:row_order)[1]
    f.custom_name = "free ice cream"
    f.save

    user.cheetah_factor_rankings << CheetahFactorRanking.new(cheetah_factor: CheetahFactor.where(user_id: nil)[0])
    user.cheetah_factor_rankings << CheetahFactorRanking.new(cheetah_factor: CheetahFactor.where(user_id: nil)[1])
  end
end
