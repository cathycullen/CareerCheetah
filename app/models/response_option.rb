class ResponseOption < ActiveRecord::Base
  include RankedModel

  belongs_to :question
  belongs_to :factor

  validates_presence_of :description, :question_id
  ranks :row_order, :with_same => :question_id
end
