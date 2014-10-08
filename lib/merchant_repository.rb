require 'pry'
require 'csv'
require_relative 'merchant'
require './lib/repository_helper'

class MerchantRepository
  include Repository

  attr_reader :filename,
              :engine,
              :read_csv,
              :all

  def initialize(engine, filename = '../data/merchants.csv')
    @filename = filename
    @all    ||= build_merchant
    @engine   = engine
  end

  def read_csv
   @data_to_array = CSV.read(filename, headers: true, header_converters: :symbol)
  end

  def build_merchant
   read_csv.collect {|data| Merchant.new(data, engine)}
    CSV.read(filename, headers: true, header_converters: :symbol)
   end

  def build_merchant # possibly change to plural
    read_csv.collect {|data| Merchant.new(data, self)}
  end


  # def find_by_x(match)
  # end
  #
  # def find_all_by_x(match)
  # end
end
