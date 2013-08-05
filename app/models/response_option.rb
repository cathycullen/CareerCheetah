class ResponseOption < ActiveRecord::Base
  include RankedModel

  belongs_to :question
  belongs_to :factor

  ranks :row_order, :with_same => :question_id

  validates_presence_of :description, :question_id, :row_order
end
