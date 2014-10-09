require 'pry'
require 'csv'
require_relative 'customer'

class CustomerRepository
  attr_reader :filename,
              :engine,
              :all,
              :read_csv

  def initialize(engine, filename = '../data/customers.csv')
    @filename = filename
    @engine   = engine
    @all    ||= build_customers
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def read_csv
    CSV.read(filename, headers: true, header_converters: :symbol)
  end

  def build_customers
    read_csv.collect {|data| Customer.new(data, self)}
  end

  def random
    @all.sample
  end

  def find_invoice_by_customer_id(id)
    engine.find_invoice_by_customer_id(id)
  end

  #define find_by's

  def find_by(attribute, match)
    all.find { |i| i.send(attribute) == match }
  end

  def find_all_by(attribute, match)
    all.select { |i| i.send(attribute) == match }
  end

  #find by methods for a single case

  def find_by_id(match)
    find_by(:id, match)
  end

  def find_by_first_name(match)
    find_by(:first_name, match)
  end

  def find_by_last_name(match)
    find_by(:last_name, match)
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

  def find_all_by_first_name(match)
    find_by(:first_name, match)
  end

  def find_all_by_last_name(match)
    find_by(:last_name, match)
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
