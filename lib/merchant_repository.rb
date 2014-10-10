require 'pry'
require 'csv'
require_relative 'merchant'

class MerchantRepository

  attr_reader :filename,
              :engine,
              :read_csv,
              :all

  def initialize(engine, filename)
    @filename   = filename
    @all      ||= build_merchants
    @engine     = engine
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def read_csv
    CSV.read(filename, headers: true, header_converters: :symbol)
  end

  def build_merchants
    read_csv.collect {|data| Merchant.new(data, self)}
  end

  def random
    @all.sample
  end

  #the following code will be called from the engine when asked

  def find_merchant_by_id(id)
     all.select{ |i| i.merchant_id == id }
  end

  #the following two methods allow merchant_repository to talk to sales engine
  #they are called in merchant.rb (one step down on tree)

  def find_items_by_id(id)
    engine.find_items_by_merchant_id(id)
  end

  def find_invoices_by_id(id)
    engine.find_invoices_by_merchant_id(id)
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

  def find_all_by_created_at(created_at)
    find_all_by(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_all_by(:updated_at, updated_at)
  end
end
