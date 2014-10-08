require 'pry'
require 'csv'
require_relative 'item'
require './lib/transaction'


class TransactionRepository
  include Repository
    attr_reader :filename,
                :engine,
                :all,
                :read_csv


  def initialize(engine, filename = '../data/invoice_items.csv')
    @filename = filename
    @engine   = engine
    @all    ||= build_transactions
  end

  def read_csv
    CSV.read(filename, headers: true, header_converters: :symbol)
  end

  def build_items
    read_csv.collect {|data| Transaction.new(data, self)}
  end

  def random
    @all.sample
  end