require 'pry'
require 'csv'
require_relative 'merchant'
require './lib/method_helper'

class MerchantRepository
  include Repository

  attr_reader :filename,
  :engine,
  :read_csv, #fix later
  :all

  def initialize(engine, filename = '../data/merchants.csv')
    @filename = filename
    @all    ||= build_merchant
    @engine   = engine
  end

  def read_csv
    CSV.read(filename, headers: true, header_converters: :symbol)
  end

  def build_merchant # possibly change to plural
    read_csv.collect {|data| Merchant.new(data, self)}
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
