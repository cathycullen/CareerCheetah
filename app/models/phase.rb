class Phase < ActiveRecord::Base
  include RankedModel

  belongs_to :program
  has_many :sections, :dependent => :destroy

  validates_presence_of :name

  ranks :row_order, :with_same => :program_id
  acts_as_url :name, :url_attribute => :slug

  def to_param
    slug
  end

  def next_phase
    program.phases.rank(:row_order).where(["row_order > ?", row_order]).first
  end

  def previous_phase
    program.phases.rank(:row_order).where(["row_order < ?", row_order]).last
  end
end
