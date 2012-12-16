#!/usr/bin/env ruby

require 'mongo_mapper'
require 'csv'
load 'class/BudgetLine.rb'
load 'class/ConfigurationMappingArticles.rb'

MongoMapper.database = 'hack4'
configFile = '/home/draudemorvan/Dropbox/hackathon/SOCIAL.csv'

puts "Reading configuration"
allMappings = []
CSV.foreach(configFile,
		:headers => true,
		:quote_char	=> '"',
		:col_sep	=>',',
                :converters	=> :numeric) do |row|
	allMappings << ConfigMappingArticles.new(row[0], row[1], row[3], row[4], row[5])
end
# Display all mappings
puts "#{allMappings.length} configurations from CSV"

puts "Flag data thematique / modele in database"
for mapping in allMappings
  @value = BudgetLine.where(:code_chapitre => mapping.chapitre, :code_ss_fonction => mapping.fonction, :code_article => mapping.article).first
  if @value
     @value.set(:thematique => mapping.thematique)
     @value.set(:modele => mapping.modele)
  end
end
