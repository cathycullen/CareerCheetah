class Phase < ActiveRecord::Base
  has_many :program_phase_mappings
  has_many :programs, :through => :program_phase_mappings

  has_many :phase_section_mappings
  has_many :sections, :through => :phase_section_mappings

  validates_presence_of :name
  validates_uniqueness_of :name

  acts_as_url :name, :url_attribute => :slug

  def to_param
    slug
  end
end
