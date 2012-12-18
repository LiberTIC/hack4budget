#!/usr/bin/env ruby

# Export t-uple of all thematique + modele from mongo database
# It will only export thematique + modele which match at least one line in budget
#
# Author: Damien Raude-Morvan <drazzib@drazzib.com>

classdir = File.expand_path(File.join(File.dirname(__FILE__), "../class"))
$LOAD_PATH.unshift(classdir) unless $LOAD_PATH.include?(classdir)

require 'mongo_mapper'

MongoMapper.setup({'production' => {'uri' => ENV['MONGOHQ_URL']}}, 'production')

cmd = {
  aggregate: 'budget_lines',
  pipeline: [
    {'$match' => {:montant => {'$gt' => 0}, :d_r => "D"}}, # Filter on 'D'epenses
    {'$group' => {:_id => {thematique: '$thematique', modele: '$modele'}}},
    {'$sort' => {'_id.thematique' => -1, '_id.modele' => -1}}
  ]
}

result = MongoMapper.database.command(cmd)['result']
for item in result
  if item['_id'] and item['_id']['thematique'] and item['_id']['modele']
    puts item['_id']['thematique'] + "," + item['_id']['modele']
  end
end