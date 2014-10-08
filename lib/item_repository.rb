require_relative 'item'
require './lib/repository'


class ItemRepository
  include Repository
  attr_reader :parse,
              :engine,
              :data

  def initialize(engine, filename = '../data/items.csv')
    @filename = filename
    @engine   = engine
    @all    ||= build_items
  end

  def read_csv
    CSV.read(filename, headers: true, header_converters: :symbol)
  end

  def build_items
    read_csv.collect {|data| Item.new(data, self)}
  end

  def random
    @all.sample
  end

  def find_by_merchant_id(id)
    all.select{ |i| i.merchant_id == id }
  end

 end
