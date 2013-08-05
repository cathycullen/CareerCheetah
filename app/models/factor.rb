class Factor < ActiveRecord::Base
  belongs_to :factor_category
  has_many :factor_selections
  has_many :users, :through => :factor_selections
  
  has_many :career_factor_mappings
  has_many :careers, :through => :career_factor_mappings

  validates_presence_of :description, :slug

  acts_as_url :description, :url_attribute => :slug
end
