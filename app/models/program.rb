class Program < ActiveRecord::Base
  has_many :program_phases
  has_many :phases, :through => :program_phases

  acts_as_url :name, :url_attribute => :slug
end
