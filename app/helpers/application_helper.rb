module ApplicationHelper
  def current_program
    @program ||= Program.find_by_slug(ENV['PROGRAM'] || "career-cheetah")
  end
end
