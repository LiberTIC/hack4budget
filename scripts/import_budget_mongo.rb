#!/usr/bin/env ruby

# Import all budget CSV file into mongodb database.
#
# Author: Damien Raude-Morvan <drazzib@drazzib.com>

require 'mongo_mapper'
require 'csv'
load 'class/BudgetLine.rb'

MongoMapper.database = 'hack4'
dataFile = '/home/draudemorvan/incoming/BP_2011_VDN_csv/BP_2011_VDN.csv'

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
