require 'pry'
require 'csv'
require_relative 'merchant'

class MerchantRepository
  include Repository

  attr_reader :filename,
              :engine

  def initialize(filename = './data/merchants.csv', engine)
    @filename = filename
    @engine   = engine
  end

  def read_csv
   @data_to_array = CSV.read (@filename, :headers true, header_converters: :symbol)
   @data_to_array.collect {|data| Merchant.new(data)}
  end


end