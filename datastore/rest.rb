#!/usr/bin/env ruby

# Simple REST interface for aggregate
#
# Author: Damien Raude-Morvan <drazzib@drazzib.com>

require 'rubygems'
require 'mongo'
require 'sinatra'
require 'json'

configure do
  CONN  = Mongo::Connection.new
  DB    = 'hack4'
  COLL  = 'budget_lines'
end

get '/api' do
  cmd = {
  aggregate: COLL,
  pipeline: [
      {'$match' => {:montant => {'$gt' => 0}, :d_r => "D"}}, # Filter on 'D'epenses
      {'$group' => {
	:_id => {category: '$thematique', model: '$modele'},
	:count => {'$sum' => 1},
	:sum => {'$sum' => '$montant'}
      }},
      {'$sort' => {'_id.category' => -1, '_id.item' => -1}}
    ]
  }

  res = CONN[DB].command(cmd)['result']
  content_type 'application/json'
  res.to_a.to_json
end