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

  # def find_by_id
  #   engine.
  # end



  #
  # def find_by_x(match)
  # end
  #
  # def find_all_by_x(match)
  # end
end
