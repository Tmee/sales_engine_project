require 'pry'
require 'csv'
require_relative 'transaction'

class TransactionRepository
#  include Repository
    attr_reader :filename,
                :engine,
                :read_csv,
                :all

  def initialize(engine, filename = '../data/transactions.csv')
    @filename = filename
    @all    ||= build_transactions
    @engine   = engine
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def read_csv
    CSV.read(filename, headers: true, header_converters: :symbol)
  end

  def build_transactions
    read_csv.collect {|data| Transaction.new(data, self)}
  end

  def random
    @all.sample
  end

  def find_invoice_by_invoice_id(invoice_id)
    engine.find_invoice_by_invoice_id(invoice_id)
  end

  def find_items_by_invoice_id(invoice_id)
    engine.find_items_by_invoice_id(invoice_id)
  end

  def find_by(attribute, value)
    all.find { |m| m.send(attribute) == value }
  end

  def find_by_id(id)
    find_by(:id, id)
  end

  def find_by_invoice_id(invoice_id)
    find_by(:invoice_id, invoice_id)
  end

  def find_by_credit_card_number(credit_card_number)
    find_by(:credit_card_number, credit_card_number)
  end

  def find_by_credit_card_expiration_date(credit_card_expiration_date)
    find_by(:credit_card_expiration_date, credit_card_expiration_date)
  end

  def find_by_result(result)
    find_by(:result, result)
  end

  def find_by_created_at(created_at)
    find_by(:created_at, created_at)
  end

  def find_by_updated_at(updated_at)
    find_by(:updated_at, updated_at)
  end

end
