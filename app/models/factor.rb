class Factor < ActiveRecord::Base
  has_many :factor_selections, :dependent => :destroy
  has_many :users, :through => :factor_selections

  has_many :career_factor_mappings, :dependent => :destroy
  has_many :careers, :through => :career_factor_mappings

  validates_presence_of :description, :slug

  acts_as_url :description, :url_attribute => :slug, :limit => 255
end
