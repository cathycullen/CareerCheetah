class SectionQuestionMapping < ActiveRecord::Base
  include RankedModel

  belongs_to :section
  belongs_to :question

  ranks :row_order, :with_same => :section_id
end
