require 'simplecov'
SimpleCov.start do
  add_fiter '/test/'
end

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require_relative '../lib/*.rb