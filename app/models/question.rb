class Question < ActiveRecord::Base
  has_many :section_question_mappings
  has_many :sections, :through => :section_question_mappings
end
