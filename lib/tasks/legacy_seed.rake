namespace :legacy_seed do
  desc "Add user careers and custom cheetah factors to existing users"
  task :create_careers_and_custom_factors => :environment do
  puts "Creating user careers and custom factors for existing users"
    User.all.each do |u|
      if u.user_careers.empty?
        10.times do
          u.user_careers << UserCareer.new
        end
      end

      if u.custom_cheetah_factors.empty?
        5.times do
          u.custom_cheetah_factors << CheetahFactor.new
        end
      end
    end
  end
end
