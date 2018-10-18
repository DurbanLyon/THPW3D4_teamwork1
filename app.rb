require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib/app", __FILE__)
require 'townhalls_scrapper'
require 'google'

Scrapp_mairie.new.create