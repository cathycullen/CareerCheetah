class ResponseOption < ActiveRecord::Base
  include RankedModel

  belongs_to :question
  belongs_to :factor
  belongs_to :cheetah_factor

  validates_presence_of :question_id
  ranks :row_order, :with_same => :question_id
end
