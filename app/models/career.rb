class Career < ActiveRecord::Base
  has_many :factors

  validates_presence_of :onet_code, :title, :description, :job_zone
end
