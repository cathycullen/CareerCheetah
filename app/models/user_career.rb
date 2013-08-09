class UserCareer < ActiveRecord::Base
  belongs_to :user
  belongs_to :career
  
  validates_presence_of :user_id
end
