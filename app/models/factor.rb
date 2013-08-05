class Factor < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :description, :slug

  acts_as_url :description, :url_attribute => :slug
end
