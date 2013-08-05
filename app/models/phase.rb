class Phase < ActiveRecord::Base
  has_many :program_phases
  has_many :programs, :through => :program_phases

  acts_as_url :name, :url_attribute => :slug
end
