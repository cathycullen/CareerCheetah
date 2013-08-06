class ProgramPhaseMapping < ActiveRecord::Base
  include RankedModel

  belongs_to :phase
  belongs_to :program

  validates_presence_of :row_order

  ranks :row_order
end
