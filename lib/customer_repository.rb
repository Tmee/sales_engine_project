require 'pry'
require 'csv'
require_relative 'customer'
require './lib/repository'


class CustomerRepository
  include Repository


  def initialize(engine, filename = '../data/customers.csv')
    @filename = filename
    @engine   = engine
    @all    ||= build_customers
  end

  def read_csv
    CSV.read(filename, headers: true, header_converters: :symbol)
  end

  def build_items
    read_csv.collect {|data| Customer.new(data, self)}
  end

  def random
    @all.sample
  end