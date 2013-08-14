class SectionStep < ActiveRecord::Base
  include RankedModel
  belongs_to :section

  ranks :row_order, :with_same => :section_id, :class_name => "SectionStep"

  def next_step
    section.section_steps.rank(:row_order).where(["row_order > ?", row_order]).first
  end

  def previous_step
    section.section_steps.rank(:row_order).where(["row_order < ?", row_order]).last
  end
end
