require 'csv'
require 'time'
require_relative 'invoice'

class InvoiceRepository

    attr_reader :filename,
                :engine,
                :read_csv,
                :all

  def initialize(engine, filename = '../data/invoices.csv')
    @filename = filename
    @all    ||= build_invoices
    @engine   = engine
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def read_csv
    CSV.read(filename, headers: true, header_converters: :symbol)
  end

  def build_invoices
    read_csv.collect {|data| Invoice.new(data, self)}
  end

  def random
    @all.sample
  end

  def create(new_invoice_data)
    new_invoice = {}

    new_invoice[:id]          = all.length + 1
    new_invoice[:customer_id] = new_invoice_data[:customer].id
    new_invoice[:merchant_id] = new_invoice_data[:merchant].id
    new_invoice[:status]      = new_invoice_data[:status]
    new_invoice[:created_at]  = Time.new.to_s
    new_invoice[:updated_at]  = Time.new.to_s

    new_invoice_item(
      new_invoice_data[:items],
      new_invoice[:id],
      new_invoice[:created_at]
    )

    invoice = Invoice.new(new_invoice, self)
    @all << invoice
    invoice
  end

  def new_invoice_item(items, id, time)
    engine.create_items(items, id, time)
  end


  #the following methods allow invoice_repository to talk to sales engine
  #they are called in invoice.rb (one step down on tree)

  def create_transaction(transaction_data)
    engine.create_transaction(transaction_data)
  end

  def find_invoice_by_invoice_id(id)
    engine.find_invoice_by_invoice_id(id)
  end

  def find_transactions_by_invoice_id(id)
    engine.find_transactions_by_invoice_id(id)
  end

  def find_invoice_items_by_id(id)
    engine.find_invoice_items_by_id(id)
  end

  def find_customer_by_customer_id(customer_id)
    engine.find_customer_by_customer_id(customer_id)
  end

  def find_items_by_id_within_invoice_items(id)
    engine.find_items_by_id_within_invoice_items(id)
  end

  def find_merchant_by_merchant_id(merchant_id)
    engine.find_merchant_by_id(merchant_id)
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

  def find_by_customer_id(customer_id)
    find_by(:customer_id, customer_id)
  end

  def find_by_merchant_id(merchant_id)
    find_by(:merchant_id, merchant_id)
  end

  def find_by_status(status)
    find_by(:status, status)
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

  def find_all_by_customer_id(customer_id)
    find_all_by(:customer_id, customer_id)
  end

  def find_all_by_merchant_id(merchant_id)
    find_all_by(:merchant_id, merchant_id)
  end

  def find_all_by_status(status)
    find_all_by(:status, status)
  end

  def find_all_by_created_at(created_at)
    find_all_by(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_all_by(:updated_at, match)
  end
end
