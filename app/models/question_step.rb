class QuestionStep < SectionStep
  belongs_to :question, :dependent => :destroy
end
