class CheetahFactor < ActiveRecord::Base
  include RankedModel

  belongs_to :user
  has_one :response_option
  has_many :cheetah_factor_rankings

  ranks :row_order

  def self.passion_factor
    @factor ||= CheetahFactor.find_by(career_rating_prompt: "On a scale of 1-5, how likely is it that I will feel passionate about the career of")
  end
end
