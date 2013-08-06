class SectionQuestionMapping < ActiveRecord::Base
  include RankedModel

  belongs_to :section
  belongs_to :question

  validates_presence_of :section_id, :question_id

  ranks :row_order, :with_same => :section_id
end
