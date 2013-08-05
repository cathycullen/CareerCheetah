class PhaseSectionMapping < ActiveRecord::Base
  belongs_to :phase
  belongs_to :section
end
