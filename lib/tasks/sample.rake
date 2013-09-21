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
    print "Deleting all exisitng response option selections..."
    ResponseOptionSelection.destroy_all
    CareerSuggestion.destroy_all
    puts "done"

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
    print "\tCreating sections for phase one..."
    phase = Phase.where(:name => "Phase One").first
    SectionImporter.import_sections_for_phase(phase, "db/seed_data/phase_one.yml")
    puts "done"

    # Sections & Questions
    print "\tCreating sections for phase two..."
    phase = Phase.where(:name => "Phase Two").first
    SectionImporter.import_sections_for_phase(phase, "db/seed_data/phase_two.yml")
    puts "done"
  end

  desc "Remove existing example users then insert sample used based on the CSVs in db/seed_data"
  task :phase_two => :environment do
    p = Program.find_by(:name => "Career Cheetah Default")
    print "\tCreating phase two..."
    ["Phase Two"].each do |name|
      p.phases.create!(:name => name)
    end
    puts "done"

    # Sections & Questions
    print "\tCreating sections..."
    phase = Phase.where(:name => "Phase Two").first
    SectionImporter.import_sections_for_phase(phase, "db/seed_data/phase_two.yml")
    puts "done"
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


    user.cheetah_factor_rankings << CheetahFactorRanking.new(cheetah_factor: CheetahFactor.where(user_id: nil).first)
    user.cheetah_factor_rankings << CheetahFactorRanking.new(cheetah_factor: CheetahFactor.where(user_id: nil).last)
  end
end

