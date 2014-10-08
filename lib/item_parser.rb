# require 'pry'
# require 'csv'
# require_relative 'item_repository'

# class ItemParser
#     attr_reader :all,
#                 :filename,
#                 :engine


#   def initialize(engine, filename = '../data/items.csv')
#     @filename = filename
#     @engine   = engine
#     @all    ||= build_items
#   end

#   def read_csv
#     CSV.read(filename, headers: true, header_converters: :symbol)
#   end

#   def build_items
#     read_csv.collect {|data| Item.new(data, self)}
#   end
# end