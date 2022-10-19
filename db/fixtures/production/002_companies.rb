require 'csv'

companies = []

CSV.foreach('db/csv/shangrila.csv') do |row|
  name = row[15]
  next if name.nil? || name == ""

  companies << {
    name: name
  }
end

Company.seed(companies.uniq)
