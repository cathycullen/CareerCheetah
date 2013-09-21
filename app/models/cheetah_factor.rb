class CheetahFactor < ActiveRecord::Base
  include RankedModel

  belongs_to :user
  has_one :response_option

  ranks :row_order
end
