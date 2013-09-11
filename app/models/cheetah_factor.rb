class CheetahFactor < ActiveRecord::Base
  belongs_to :user
  has_one :response_option
end
