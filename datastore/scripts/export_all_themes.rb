#!/usr/bin/env ruby

# Export t-uple of all thematique + modele from mongo database
# It will only export thematique + modele which match at least one line in budget
#
# Author: Damien Raude-Morvan <drazzib@drazzib.com>

require 'rubygems'
require 'mongo'

include Mongo

@client = MongoClient.new('localhost', 27017)
@db     = @client['hack4']

cmd = {
  aggregate: 'budget_lines',
  pipeline: [
    {'$match' => {:montant => {'$gt' => 0}, :d_r => "D"}}, # Filter on 'D'epenses
    {'$group' => {:_id => {thematique: '$thematique', modele: '$modele'}}},
    {'$sort' => {'_id.thematique' => -1, '_id.modele' => -1}}
  ]
}

result = @db.command(cmd)['result']
for item in result
  if item['_id'] and item['_id']['thematique'] and item['_id']['modele']
    puts item['_id']['thematique'] + "," + item['_id']['modele']
  end
end