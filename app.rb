$:.unshift File.expand_path("./../lib/views", __FILE__)


require 'bundler'
require 'index'
require 'dotenv/load'
require 'json'



Bundler.require
Index.new
