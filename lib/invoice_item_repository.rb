require 'pry'
require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepository

    attr_reader :filename,
                :engine,
                :read_csv,
                :all

  def initialize(engine, filename = '../data/invoice_items.csv')
    @filename = filename
    @all    ||= build_invoice_items
    @engine   = engine
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def read_csv
    CSV.read(filename, headers: true, header_converters: :symbol)
  end

  def build_invoice_items
    read_csv.collect {|data| InvoiceItem.new(data, self)}
  end

  def random
    @all.sample
  end

  #the following two methods allow invoice_item_repository to talk to sales engine
  #they are called in invoice_item.rb (one step down on tree)

  def find_invoice_by_invoice_id(invoice_id)
    engine.find_invoice_by_invoice_id(invoice_id)
  end

  def find_item_by_item_id(item_id)
    engine.find_by_item_id(item_id)
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

  def find_by_item_id(item_id)
    find_by(:item_id, item_id)
  end

  def find_by_invoice_id(invoice_id)
    find_by(:invoice_id, invoice_id)
  end

  def find_by_quantity(quantity)
    find_by(:quantity, quantity)
  end

  def find_by_unit_price(unit_price)
    find_by(:unit_price, unit_price)
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

  def find_all_by_item_id(item_id)
    find_all_by(:item_id, item_id)
  end

  def find_all_by_invoice_id(invoice_id)
    find_all_by(:invoice_id, invoice_id)
  end

  def find_all_by_quantity(quantity)
    find_all_by(:quantity, quantity)
  end

  def find_all_by_unit_price(unit_price)
    find_all_by(:unit_price, unit_price)
  end

  def find_all_by_created_at(created_at)
    find_all_by(:created_at, created_at)
  end

  def find_all_by_updated_at(updated_at)
    find_all_by(:updated_at, match)
  end
end
