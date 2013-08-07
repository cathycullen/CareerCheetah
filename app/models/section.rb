class Section < ActiveRecord::Base
  include RankedModel

  belongs_to :phase
  has_many :questions

  validates_presence_of :name
  validates_uniqueness_of :name

  ranks :row_order, :with_same => :phase_id
  acts_as_url :name, :url_attribute => :slug

  def to_param
    slug
  end
end
