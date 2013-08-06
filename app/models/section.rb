class Section < ActiveRecord::Base
  has_many :phase_section_mappings
  has_many :phases, :through => :phase_section_mappings

  has_many :section_question_mappings
  has_many :sections, :through => :section_question_mappings

  validates_presence_of :name
  validates_uniqueness_of :name
end
