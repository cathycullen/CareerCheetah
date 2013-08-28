class ResponseOptionSelection < ActiveRecord::Base
  belongs_to :user
  belongs_to :response_option

  serialize :data
end
