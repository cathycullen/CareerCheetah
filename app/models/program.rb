class Program < ActiveRecord::Base
  has_many :program_phase_mappings
  has_many :phases, :through => :program_phase_mappings

  acts_as_url :name, :url_attribute => :slug
end
