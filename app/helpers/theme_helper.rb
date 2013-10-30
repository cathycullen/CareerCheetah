module ThemeHelper
  def program_logo(program)
    if program.slug == 'jma'
      image_tag "jma-logo.png"
    else
      image_tag "cheetah-logo.png"
    end
  end
end
