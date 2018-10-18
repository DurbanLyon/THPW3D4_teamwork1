require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require 'townhalls_scrapper'
require 'google.rb'

Scrapper.new.get_all_the_urls_townhalls('yonne')