$:.unshift File.expand_path("./../lib/views", __FILE__)

require 'bundler'
require 'index'

Bundler.require
Index.new
