#!/usr/bin/env ruby

# Sample aggregate (by thematique) for budget_lines
#
# Author: Damien Raude-Morvan <drazzib@drazzib.com>

classdir = File.expand_path(File.join(File.dirname(__FILE__), "../class"))
$LOAD_PATH.unshift(classdir) unless $LOAD_PATH.include?(classdir)

require 'mongo_mapper'

MongoMapper.setup({'production' => {'uri' => ENV['OPENSHIFT_MONGODB_DB_URL']}}, 'production')

cmd = {
  aggregate: 'budget_lines',
  pipeline: [
    {'$match' => {:montant => {'$gt' => 0}, :d_r => "D"}}, # Filter on 'D'epenses
    {'$group' => {
      :_id => {thematique: '$thematique', modele: '$modele'},
      :ecount => {'$sum' => 1},
      :esum => {'$sum' => '$montant'}
    }},
    {'$sort' => {'_id.thematique' => -1, '_id.modele' => -1}}
  ]
}

res = MongoMapper.database.command(cmd)['result']
puts res