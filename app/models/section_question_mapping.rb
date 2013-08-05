class SectionQuestionMapping < ActiveRecord::Base
  belongs_to :section
  belongs_to :question

  ranks :row_order
end
