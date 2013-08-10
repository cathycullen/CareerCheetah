require 'csv'
if ARGV[1] == "-q"
  CSV.foreach(ARGV[0]) do |row|
   puts "- prompt: \"#{row[5]} #{row[0]}\""
   puts "  responses:"
   puts "    - description: \"Yes\""
   puts "      element_code: \"#{row[1]}\""
   puts "    - description: \"No\""
   puts "      element_code: \"\""
  end
else
  CSV.foreach(ARGV[0]) do |row|
   puts "- description: \"#{row[0]}\""
   puts "  element_code: \"#{row[1]}\""
   puts "  fit_code: \"#{row[2]}\""
  end
end
