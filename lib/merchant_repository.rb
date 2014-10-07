require 'pry'
require 'csv'
require_relative 'merchant'
require './lib/method_helper'

class MerchantRepository
  include Repository

  attr_reader :filename,
              :engine
              :data_to_array

  def initialize(filename = '../data/merchants.csv', engine)
    @filename = filename
    @engine   = engine
  end

  def read_csv
   @data_to_array = CSV.read(filename, headers: true, header_converters: :symbol)
 end

  def build_merchant
   @data_to_array.collect {|data| Merchant.new(data, engine)}
  end

  def all(filename)
    @all ||= build_merchant
  end

  # def random
  #   @all.sample
  # end
  #
  # def find_by_x(match)
  # end
  #
  # def find_all_by_x(match)
  # end
end
