module FactorRating
  def rating_options
    [
      {value: 0, value_description: "Delete Factor", description: "IT'S NOT IMPORTANT AT ALL"},
      {value: 1, value_description: "1", description: "NOT THAT IMPORTANT"},
      {value: 2, value_description: "2", description: "PRETTY IMPORTANT"},
      {value: 3, value_description: "3", description: "IMPORTANT"},
      {value: 4, value_description: "4", description: "VERY IMPORTANT"},
      {value: 5, value_description: "5", description: "IT'S A MUST"}
    ]
  end
end
