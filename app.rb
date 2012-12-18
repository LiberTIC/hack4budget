#!/usr/bin/env ruby

# Simple REST interface for aggregate
#
# Author: Damien Raude-Morvan <drazzib@drazzib.com>

classdir = File.expand_path(File.join(File.dirname(__FILE__), "class"))
$LOAD_PATH.unshift(classdir) unless $LOAD_PATH.include?(classdir)

require 'sinatra'
require 'json'
require 'mongo'
require 'mongo_mapper'

configure do
	db = "mongodb://localhost/hackbudget"
	if ENV['OPENSHIFT_MONGODB_DB_URL']
		db = "#{ENV['OPENSHIFT_MONGODB_DB_URL']}hackbudget"
	end
	MongoMapper.setup({'production' => {'uri' => db}}, 'production')
	COLL  = 'budget_lines'
end

get "/" do
  redirect '/index.html'
end

get '/api/themes' do
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

  res = MongoMapper.database.command(cmd)['result']
  content_type :json
  res.to_a.to_json
end

get '/api/incomes' do
  cmd = {
  aggregate: COLL,
  pipeline: [
      {'$match' => {:montant => {'$gt' => 0}, :d_r => "R"}}, # Filter on Revenu
      {'$group' => {
	:_id => nil,
	:sum => {'$sum' => '$montant'}
      }},
    ]
  }

  res = MongoMapper.database.command(cmd)['result']
  content_type :json
  sum = 0
  if res and res[0]
	  sum = res[0]['sum']
  end
  {:income => sum,
        :debts => 0,
        :savings => 0}.to_json
end
