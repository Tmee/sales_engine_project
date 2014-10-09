require 'pry'
require 'csv'
require_relative 'item_'
# require './lib/repository'

class ItemRepository
  # include Repository
  attr_reader :parse,
              :engine,
              :data,
              :filename

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

  #the following code will be called from the engine when asked

  def find_by_merchant_id(id)
    all.select{ |i| i.merchant_id == id }
  end


  #the following two methods allow item_repository to talk to sales engine
  #they are called in item.rb (one step down on tree)

  def find_invoice_items_by_id(id)
    engine.find_invoice_items_by_id(id)
  end

  def find_merchant_by_id(id)
    engine.find_merchant_by_id(id)
  end

  #define find_by's

  def find_by(attribute, match)
    all.find { |m| m.send(attribute) == value }
  end

  def find_all_by(attribute, match)
    all.select { |i| i.send(attribute) == value }
  end

  #find by methods for a single case

  def find_by_id(match)
    find_by(:id, match)
  end

  def find_by_name(match)
    find_by(:name, match)
  end

  def find_by_unit_price(match)
    find_by(:unit_price, match)
  end

  def find_by_merchant_id(match)
    find_by(:merchant_id, match)
  end

  def find_by_created_at(match)
    find_by(:created_at, match)
  end

  def find_by_updated_at(match)
    find_by(:updated_at, match)
  end

  #find by methods for all cases

  def find_all_by_id(match)
    find_all_by(:id, match)
  end

  def find_all_by_name(match)
    find_all_by(:name, match)
  end

  def find_all_by_unit_price(match)
    find_all_by(:unit_price, match)
  end

  def find_all_by_merchant_id(match)
    find_all_by(:merchant_id, match)
  end

  def find_all_by_created_at(match)
    find_all_by(:created_at, match)
  end

  def find_all_by_updated_at(match)
    find_all_by(:updated_at, match)
  end
 end
