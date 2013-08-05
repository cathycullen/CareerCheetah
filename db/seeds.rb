require 'csv'

Factor.destroy_all
# Import Factors
CSV.foreach(File.join(Rails.root, "db/seed_data/classes.csv")) do |row|
  Factor.create!(:description => row[1], :onet_code => row[0])
end
