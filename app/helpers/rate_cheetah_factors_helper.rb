module RateCheetahFactorsHelper
  def career_rating_options
    [
      {value: 1, value_description: "1", description: "NOT A CHANCE"},
      {value: 2, value_description: "2", description: "NOT VERY LIKELY"},
      {value: 3, value_description: "3", description: "SOMEWHAT LIKELY"},
      {value: 4, value_description: "4", description: "LIKELY"},
      {value: 5, value_description: "5", description: "EXTREMELY LIKELY"}
    ]
  end
end
