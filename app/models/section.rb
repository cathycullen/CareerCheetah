class Section < ActiveRecord::Base
  has_many :phase_section_mappings
  has_many :phases, :through => :phase_section_mappings
end
