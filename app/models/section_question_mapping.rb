class SectionQuestionMapping < ActiveRecord::Base
  include RankedModel

  belongs_to :section
  belongs_to :question

  validates_presence_of :section_id, :question_id

  ranks :row_order, :with_same => :section_id

  def next
    section.section_question_mappings
      .rank(:row_order).where(["row_order > ?", row_order]).first
  end

  def previous
    section.section_question_mappings
      .rank(:row_order).where(["row_order < ?", row_order]).first
  end
end
