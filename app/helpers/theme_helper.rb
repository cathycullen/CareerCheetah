module ThemeHelper
  def program_logo(size=nil)
    if current_program.jma?
      if size == :large
        image_tag "jma-logo-large.png"
      else
        image_tag "jma-logo.png"
      end
    else
      if size == :large
        image_tag "cheetah-logo-large.png"
      else
        image_tag "cheetah-logo.png"
      end
    end
  end

  def program_name
    if current_program.jma?
      "JMA Career Test"
    else
      "Career Cheetah"
    end
  end

  def welcome_prompt
    if current_program.jma?
      "Welcome to the JMA Career Test"
    else
      "Welcome to Career Cheetah"
    end
  end
end
