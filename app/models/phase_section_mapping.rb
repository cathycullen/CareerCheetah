class PhaseSectionMapping < ActiveRecord::Base
  include RankedModel

  belongs_to :phase
  belongs_to :section

  validates_presence_of :phase_id, :section_id

  ranks :row_order, :with_same => :phase_id
end
