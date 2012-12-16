#!/usr/bin/env ruby

# Simple REST interface for aggregate
#
# Author: Damien Raude-Morvan <drazzib@drazzib.com>

require 'rubygems'
require 'mongo'
require 'sinatra'
require 'sinatra/json'
require 'json'

configure do
  CONN  = Mongo::Connection.new
  DB    = 'hack4'
  COLL  = 'budget_lines'
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

  res = CONN[DB].command(cmd)['result']
  content_type 'application/json'
  res.to_a.to_json
end

get '/api/incomes' do
  cmd = {
  aggregate: COLL,
  pipeline: [
      {'$match' => {:montant => {'$gt' => 0}, :d_r => "R"}}, # Filter on Revenu
      {'$group' => {
	:_id => 'all',
	:sum => {'$sum' => '$montant'}
      }},
    ]
  }

  res = CONN[DB].command(cmd)['result']
  content_type 'application/json'
  json({'income' => res[0]['sum'], 'debts' => 0, 'savings' => 0})
end