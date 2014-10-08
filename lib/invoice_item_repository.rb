require 'pry'
require 'csv'
require_relative 'item'
require './lib/invoice_item'


class InvoiceItemRepository
  include Repository
    attr_reader :filename,
                :engine,
                :all,
                :read_csv


  def initialize(engine, filename = '../data/invoice_items.csv')
    @filename = filename
    @engine   = engine
    @all    ||= build_invoice_items
  end

  def read_csv
    CSV.read(filename, headers: true, header_converters: :symbol)
  end

  def build_items
    read_csv.collect {|data| InvoiceItem.new(data, self)}
  end

  def random
    @all.sample
  end