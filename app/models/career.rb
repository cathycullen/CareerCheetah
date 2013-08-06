class Career < ActiveRecord::Base
  has_many :career_factor_mappings
  has_many :factors, :through => :career_factor_mappings

  validates_presence_of :onet_code, :title, :description, :job_zone
  validates_uniqueness_of :onet_code	
end
