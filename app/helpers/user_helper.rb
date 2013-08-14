module UserHelper
  def best_work_fit

    # compute best work fit sums by categories for current_user
    # return hash table with categories and sums
    fit_codes_summary = []
    codes = ['Corporate', 'Freelance', 'Entrepreneur', 'Non-profit']
    codes.each do  |code|
      code_count = 0
      @user.response_option_selections.each do |response_option|
        code_count += response_option = ResponseOption.where(:id => response_option.response_option_id).where(:fit_code => code[0]).size
      end

      fit_codes_summary <<  { :fit_code => code, :count => code_count}
      # puts "Code Count for #{code} is : #{code_count}"
    end
  end

  def fit_count_by_type(fit_code)
    # compute sum of fit_codes for this current_user and fit_code
    sum = 0
    @user.response_option_selections.each do |ros|
      sum += ResponseOption.where(:id => ros.response_option_id).where(:fit_code => fit_code).size
    end
  sum      
  end

end
