require 'pry'
require 'csv'
require_relative 'item'

class ItemRepository

  attr_reader :filename,
              :engine,
              :read_csv,
              :all

  def initialize(engine, filename = '../data/items.csv')
    @filename = filename
    @all    ||= build_items
    @engine   = engine
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
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

  def most_revenue(x)
    all.sort_by { |i| i.revenue }.reverse[0..x-1]
  end

  def most_items(x=1)
    all.sort_by { |i| i.total_items }.reverse[0..x-1]
  end

  #the following two methods allow item_repository to talk to sales engine
  #they are called in item.rb (one step down on tree)

  def find_invoice_items_by_id(id)
    engine.find_invoice_items_by_item_id(id)
  end

  def find_merchant_by_merchant_id(id)
     engine.find_by_merchant_id(id)
  end

  #find_by

  def find_by(attribute, match)
    all.find { |m| m.send(attribute) == match }
  end

  def find_all_by(attribute, match)
    all.select { |i| i.send(attribute) == match }
  end

  #find_by methods for a single case

  def find_by_id(id)
    find_by(:id, id)
  end

  def find_by_name(name)
    find_by(:name, name)
  end

  def find_by_description(description)
    find_by(:description, description)
  end

  def find_by_unit_price(unit_price)
    find_by(:unit_price, unit_price)
  end

  def find_by_merchant_id(merchant_id)
    find_by(:merchant_id, merchant_id)
  end

  def find_by_created_at(created_at)
    find_by(:created_at, created_at)
  end

  def find_by_updated_at(updated_at)
    find_by(:updated_at, updated_at)
  end

  #find_by methods for all cases

  def find_all_by_id(id)
    find_all_by(:id, id)
  end

  def find_all_by_name(name)
    find_all_by(:name, name)
  end

  def find_all_by_description(description)
    find_all_by(:description, description)
  end

  def find_all_by_unit_price(unit_price)
    find_all_by(:unit_price, unit_price)
  end

  def find_all_by_merchant_id(merchant_id)
    find_all_by(:merchant_id, merchant_id)
  end

  def find_all_by_created_at(created_at)
    find_all_by(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_all_by(:updated_at, match)
  end
 end
