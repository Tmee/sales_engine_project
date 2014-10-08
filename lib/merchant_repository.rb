require 'pry'
require 'csv'
require_relative 'merchant'
require './lib/repository'

class MerchantRepository
  include Repository

  attr_reader :filename,
  :engine,
  :read_csv,
  :all

  def initialize(engine, filename = '../data/merchants.csv')
    @filename = filename
    @all    ||= build_merchants
    @engine   = engine
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

  def find_items_by_id(id)
    engine.find_items_by_merchant_id(id)
  end

  def find_by_name(name)
    find_by(:name, name)
  end

  def find_by(attribute, value)
    all.find { |m| m.send(attribute) == value }
  end

  def find_by_id(id)
    find_by(:id, id)
  end



  #
  # def find_by_x(match)
  # end
  #
  # def find_all_by_x(match)
  # end
end