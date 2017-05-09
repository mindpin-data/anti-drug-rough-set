require 'rubygems'
require 'bundler/setup' 
Bundler.require

require_relative '../lib/data-set'
require_relative '../lib/data-set-record'

Mongoid.load!("config/mongoid.yml", :drug_data)

ds = RoughSet::DataSet.from_json File.read("data/disease.json")

ds.data.each {|x|
  dr = DataSetRecord.new data: x
  dr.save
}