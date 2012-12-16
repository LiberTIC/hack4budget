#!/usr/bin/env ruby

# After "import_budget_mongo.rb", alter each line in database to declare
# mapping with thematique + modele
#
# Author: Damien Raude-Morvan <drazzib@drazzib.com>

require 'mongo_mapper'
require 'csv'
load 'class/BudgetLine.rb'
load 'class/ConfigurationMappingArticles.rb'

MongoMapper.database = 'hack4'
configDir = '/home/draudemorvan/Dropbox/hackathon/thematiques/'
configs = ['ADMINISTRATIF.csv', 'CULTURE.csv', 'ECONOMIE.csv', 'EDUCATION.csv', 'ENVIRONNEMENT.csv', 'SOCIAL.csv', 'URBANISME.csv']
allMappings = []

for file in configs
  puts "Reading #{file} configuration"
  importedItem = 0
  CSV.foreach(configDir + file,
		:headers => true,
		:quote_char	=> '"',
		:col_sep	=>',',
                :converters	=> :numeric) do |row|
	allMappings << ConfigMappingArticles.new(row[0], row[1], row[2], row[3], row[4])
	importedItem += 1;
  end
  puts "Imported #{importedItem} items"
end
# Display all mappings
puts "#{allMappings.length} configurations from CSV"

puts "Flag data thematique / modele in database"
appliedMappings = 0
for mapping in allMappings
  @value = BudgetLine.where(:code_chapitre => mapping.chapitre, :code_ss_fonction => mapping.fonction, :code_article => mapping.article).first
  if @value
     @value.set(:thematique => mapping.thematique)
     @value.set(:modele => mapping.modele)
     appliedMappings += 1
  end
end
puts "#{appliedMappings} imported in DB"
