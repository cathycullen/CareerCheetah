class CheetahFactor < ActiveRecord::Base
  include RankedModel

  belongs_to :user
  has_one :response_option
  has_many :cheetah_factor_rankings
  before_save :set_rating_prompts

  ranks :row_order

  def self.passion_factor
    @factor ||= CheetahFactor.find_by(career_rating_prompt: "On a scale of 1-5, how likely is it that I will feel passionate about the career of")
  end

  def set_rating_prompts
    if self.respond_to?(:custom_name) && self.custom_name_changed?
      if self.custom_name.present?
        self.career_rating_prompt = "On a scale of 1-5, how likely is it that I will experience the factor \"#{self.custom_name}\" in the career of"
        self.rating_prompt = "On a scale of 1-5, how important is \"#{self.custom_name}\"?"
      else
        self.career_rating_prompt = nil
        self.rating_prompt = nil
      end
    end
  end
end
