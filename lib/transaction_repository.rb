require 'csv'
require_relative 'transaction'

class TransactionRepository

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

  #the following code will be called from the engine when asked

  def create_transaction(data)
    t = data

    t[:id]                          = all.length + 1
    t[:result]                      = data[:result]
    t[:created_at]                  = Time.new.to_s
    t[:updated_at]                  = Time.new.to_s

   new_transaction = Transaction.new(t, self)
   @all << new_transaction
   new_transaction
  end

  def find_results_by_invoice_id(invoice_id)
    invoices = find_all_by_invoice_id(invoice_id)
    successful_invoices = invoices.select { |i| i.result == "success" }
  end

  #the following two methods allow
  # transaction_repository to talk to sales engine
  #they are called in transaction.rb (one step down on tree)

  def find_invoice_by_invoice_id(invoice_id)
    engine.find_invoice_by_invoice_id(invoice_id)
  end

  def find_items_by_invoice_id(invoice_id)
    engine.find_items_by_invoice_id(invoice_id)
  end

  #find_by

  def find_by(attribute, match)
    all.find { |m| m.send(attribute) == match }
  end

  def find_all_by(attribute, match)
    all.select { |i| i.send(attribute) == match }
  end

  #find_by methods for a single case

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

  #find_by methods for all cases

  def find_all_by_id(id)
    find_all_by(:id, id)
  end

  def find_all_by_invoice_id(invoice_id)
    find_all_by(:invoice_id, invoice_id)
  end

  def find_all_by_credit_card_number(credit_card_number)
    find_all_by(:credit_card_number, credit_card_number)
  end

  def find_all_by_credit_card_expiration_date(credit_card_expiration_date)
    find_all_by(:credit_card_expiration_date, credit_card_expiration_date)
  end

  def find_all_by_result(result)
    find_all_by(:result, result)
  end

  def find_all_by_created_at(created_at)
    find_all_by(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_all_by(:updated_at, match)
  end

end
