#!/usr/bin/env ruby

require 'mongo_mapper'
require 'csv'
load 'class/BudgetLine.rb'
load 'class/ConfigurationMappingArticles.rb'

MongoMapper.database = 'hack4'
configDir = '/home/draudemorvan/Dropbox/hackathon/thematiques/'
configs = ['SOCIAL.csv', 'ADMINISTRATIF.csv', 'URBANISME.csv', 'ENVIRONNEMENT.csv', 'EDUCATION.csv', 'CULTURE.csv']
allMappings = []

for file in configs
  puts "Reading #{file} configuration"
  CSV.foreach(configDir + file,
		:headers => true,
		:quote_char	=> '"',
		:col_sep	=>',',
                :converters	=> :numeric) do |row|
	allMappings << ConfigMappingArticles.new(row[0], row[1], row[2], row[3], row[4])
  end
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
