require 'benchmark'
require_relative 'models/colors'

def usage
  puts 'Usage:'
  puts
  puts ''
end

def validate_required_fields
  if !ENV['ID'] || !ENV['YEAR'] || !ENV['MONTH']
    usage
    abort
  end
end

def start
  import = "ID=#{ENV['ID']} YEAR=#{ENV['YEAR']} MONTH=#{ENV['MONTH']} ruby import.rb"
  generate_sql = "ruby sql_generator.rb"
  restore_mysql = "ruby mysql_import.rb"

  system(import)
  system(generate_sql)
  system(restore_mysql)
end

time = Benchmark.realtime do
  validate_required_fields
  start
end

puts ''
puts 'Done.'
puts "Time elapsed #{time} seconds"