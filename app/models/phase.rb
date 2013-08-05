class Phase < ActiveRecord::Base
  has_many :program_phase_mappings
  has_many :programs, :through => :program_phase_mappings

  has_many :phase_section_mappings
  has_many :sections, :through => :phase_section_mappings

  acts_as_url :name, :url_attribute => :slug
end
