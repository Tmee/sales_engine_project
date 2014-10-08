require 'pry'                # => true
require 'csv'                # => true
require_relative 'merchant'  # => true
# require 'method_helper'

class MerchantRepository
  # include Repository

  attr_reader :filename,      # => :filename
              :engine         # => nil
              :data_to_array  # => :data_to_array

  def initialize(filename = '../data/merchants.csv', engine = SalesEngine.new)
    @filename = filename
    @engine   = engine
    # @data_to_array = []
  end

  def read_csv
   @data_to_array = CSV.read(filename, headers: true, header_converters: :symbol)
  end

  def all
    @all ||= build_merchant
  end

  def build_merchant
   read_csv.collect {|data| Merchant.new(data, self)}
  end

  def find_by(attribute, match)
    all.find do |merchant|
      merchant.send(attribute.to_sym).downcase.strip == match.downcase.strip
    end
  end

  def find_all_by(attribute, match)
    all.collect do |merchant|
      merchant.send(attribute.to_sym).downcase.strip == match.downcase.strip
    end
  end

  def random
    @all.sample
  end

  # #META PROGRAMMING CRAZINESS
  #   %w(id name created_at updated_at).each do |var|
  #   define_method "find_by_#{var}" do |value|
  #     all.find {|merchant| merchant.send(var.to_sym) == value}
  #   end
  # end

  #
  # def find_all_by_x(match)
  # end
end
