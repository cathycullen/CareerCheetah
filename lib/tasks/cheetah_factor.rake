namespace :cheetah_factor do
  desc "Convert existing response options with rating prompts to CheetahFactors"
  task :convert => :environment do
    puts "Converting response options to CheetahFactors..."
    cheetah_factors = []

    ResponseOption.where("rating_prompt IS NOT NULL").each do |o|
      cf = CheetahFactor.create!(:rating_prompt => o.rating_prompt)
      cheetah_factors << cf
      o.cheetah_factor = cf
      o.save!
    end

    puts "Created #{cheetah_factors.length} CheetahFactor records"
    puts "done"
  end

  task :import_career_rating_prompt => :environment do
    puts "Importing career_rating_prompts for existing CheetahFactors..."
    program_data = YAML.load_file(File.join(Rails.root, "db/seed_data/section_questions.yml"))

    program_data['sections'].each do |section_data|
      next if section_data['steps'].nil?

      question_steps = section_data['steps'].select{ |s| s['step_type'] == "Question"}
      question_steps.each do |question_step|
        question_step['responses'].each do |response_data|
          if response_data['career_rating_prompt']
            if cf = CheetahFactor.find_by(rating_prompt: response_data['rating_prompt'])
              cf.career_rating_prompt = response_data['career_rating_prompt']
              cf.save!
            else
              puts "Warning, failed to file CheetahFactor for rating_prompt #{response_data['rating_prompt']}"
            end
          end
        end
      end
    end
  end
end
