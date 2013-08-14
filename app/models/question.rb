class Question < ActiveRecord::Base
  has_many :response_options, :dependent => :destroy
  has_one :question_step

  def program
    phase.program
  end

  def phase
    section.phase
  end

  def multi?
    prompt_type == "multi"
  end

  def boolean?
    prompt_type == "boolean"
  end

  def single?
    prompt_type == "single"
  end

end
