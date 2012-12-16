#!/usr/bin/env ruby

require 'rubygems'
require 'mongo'

include Mongo

@client = MongoClient.new('localhost', 27017)
@db     = @client['hack4']

cmd = {
  aggregate: 'budget_lines',
  pipeline: [
    {'$match' => {:montant => {'$gt' => 0}, :d_r => "D"}}, # Filter on 'D'epenses
    {'$group' => {
      :_id => {thematique: '$thematique'}, # , modele: '$modele'
      :ecount => {'$sum' => 1},
      :esum => {'$sum' => '$montant'}
    }}
  ]
}

res = @db.command(cmd)['result']
puts res