class CheetahFactor < ActiveRecord::Base
  include RankedModel

  belongs_to :user
  has_one :response_option
  has_many :cheetah_factor_rankings

  ranks :row_order
end
