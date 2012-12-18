#!/usr/bin/env ruby

# Import all budget CSV file into mongodb database.
#
# Author: Damien Raude-Morvan <drazzib@drazzib.com>

classdir = File.expand_path(File.join(File.dirname(__FILE__), "../class"))
$LOAD_PATH.unshift(classdir) unless $LOAD_PATH.include?(classdir)

require 'mongo'
require 'mongo_mapper'
require 'csv'
require 'BudgetLine'

db = "mongodb://localhost/hackbudget"
if ENV['OPENSHIFT_MONGODB_DB_URL']
	db = "#{ENV['OPENSHIFT_MONGODB_DB_URL']}hackbudget"
end
MongoMapper.setup({'production' => {'uri' => db}}, 'production')

dataFile = 'data/BP_2011_VDN.csv'

puts "Remove everything"
BudgetLine.all.each { |s| s.destroy }

puts "Start import..."
# Import CSV into mongo
count = 0
CSV.foreach(dataFile,
		:headers => true,
		:quote_char     => '"',
		:col_sep        =>',',
		:converters	=> :numeric ) do |row|
budgetLine = BudgetLine.create({
  :exercice => row[0],
  :d_r => row[1],
  :i_f => row[2],
  :ordre => row[3],
  :code_chapitre => row[4],
  :code_ss_fonction => row[6],
  :code_article => row[8],
  :montant => row[10]
})
count += 1
budgetLine.save
end

puts "Imported #{count} lines"
