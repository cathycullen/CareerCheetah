class SectionQuestionMapping < ActiveRecord::Base
  belongs_to :section
  belongs_to :question
end
