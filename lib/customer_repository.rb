require 'pry'
require 'csv'
require_relative 'customer'

class CustomerRepository

  attr_reader :filename,
              :engine,
              :read_csv,
              :all

  def initialize(engine, filename = '../data/customers.csv')
    @filename = filename
    @all    ||= build_customers
    @engine   = engine
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

  #the following method allows customer_repository to talk to sales engine
  #it is called in customer.rb (one step down on tree)

  def find_invoices_by_customer_id(id)
    engine.find_invoices_by_customer_id(id)
  end

  #find_by

  def find_by(attribute, match)
    all.find { |i| i.send(attribute) == match }
  end

  def find_all_by(attribute, match)
    all.select { |i| i.send(attribute) == match }
  end

  #find by methods for a single case

  def find_by_id(id)
    find_by(:id, id)
  end

  def find_by_first_name(first_name)
    find_by(:first_name, first_name)
  end

  def find_by_last_name(last_name)
    find_by(:last_name, last_name)
  end

  def find_by_created_at(created_at)
    find_by(:created_at, created_at)
  end

  def find_by_updated_at(updated_at)
    find_by(:updated_at, updated_at)
  end

  #find by methods for all cases

  def find_all_by_id(id)
    find_all_by(:id, id)
  end

  def find_all_by_first_name(first_name)
    find_all_by(:first_name, first_name)
  end

  def find_all_by_last_name(last_name)
    find_all_by(:last_name, last_name)
  end

  def find_all_by_created_at(created_at)
    find_all_by(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_all_by(:updated_at, updated_at)
  end
 end
