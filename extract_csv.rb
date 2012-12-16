#!/usr/bin/env ruby

# require 'rubygem'
require 'faster_csv'

configFile = 'SOCIAL.csv'
dataFile = '/home/draudemorvan/incoming/BP_2011_VDN_csv/BP_2011_VDN.csv'

# Struct for mapping configuration
class ConfigMappingArticles < Struct.new(:theme, :modele, :chapitre, :fonction, :article)
  def comp(chapitre, fonction, article)
    return (self.chapitre == chapitre and self.fonction == fonction and self.article == article)
  end
end

# Read configuration
allMappings = []
FasterCSV.foreach(configFile,
		:headers => true,
		:quote_char	=> '"',
		:col_sep	=>',',
                :converters	=> :numeric) do |row|
	allMappings << ConfigMappingArticles.new(row[0], row[1], row[3], row[4], row[5])
end
# Display all mappings
puts "All configuration: #{allMappings.length} elements"

# Read and filter CSV
totals = Hash.new
FasterCSV.foreach(dataFile,
		:headers => true,
		:quote_char     => '"',
		:col_sep        =>',',
		:converters	=> :numeric ) do |row|
  for mapping in allMappings
    if mapping.comp(row[4], row[6], row[8])
      if !totals[row[1]]
	totals[row[1]] = 0
      end
      totals[row[1]] += row[10]
    end
  end
end
puts totals
