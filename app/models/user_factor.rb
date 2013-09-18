class UserFactor < ActiveRecord::Base 
  include RankedModel

  belongs_to :user
  validates_presence_of :user_id

  ranks :row_order, :with_same => :user_id

end

