class Program < ActiveRecord::Base
  has_many :phases

  validates_presence_of :name
  validates_uniqueness_of :name

  acts_as_url :name, :url_attribute => :slug

  def to_param
    slug
  end
end
