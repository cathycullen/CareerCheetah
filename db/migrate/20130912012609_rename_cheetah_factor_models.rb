class RenameCheetahFactorModels < ActiveRecord::Migration
  def change
    rename_table :user_cheetah_factors, :cheetah_factor_rankings
    convert_response_options_to_cheetah_factors
  end

  def convert_response_options_to_cheetah_factors
    puts "Converting response options to CheetahFactors..."
    cheetah_factors = []

    ResponseOption.where("rating_prompt IS NOT NULL").each do |o|
      cf = CheetahFactor.create!(:rating_prompt => o.rating_prompt)
      cheetah_factors << cf
      o.cheetah_factor = cf
      o.save!
    end

    puts "Created #{cheetah_factors.length} CheetahFactor records"

    puts "Converting RatedResponses..."
    User.all.each do |u|
      u.response_option_selections.each do |s|
        next if s.response_option.rating_prompt.nil?
        raise "Missing cheetahFactor! #{s.id}" unless s.response_option.cheetah_factor
        CheetahFactorRanking.create!(user: u,
                                     cheetah_factor: s.response_option.cheetah_factor,
                                     original_rating: s.rating)
      end
    end

    puts "done"
  end
end
