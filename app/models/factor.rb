class Factor < ActiveRecord::Base
  belongs_to :factor_category
  has_many :factor_selections
  has_many :users, :through => :factor_selections

  validates_presence_of :description, :slug

  acts_as_url :description, :url_attribute => :slug
end
