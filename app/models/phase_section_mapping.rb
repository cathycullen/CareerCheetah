class PhaseSectionMapping < ActiveRecord::Base
  include RankedModel

  belongs_to :phase
  belongs_to :section

  ranks :row_order
end
