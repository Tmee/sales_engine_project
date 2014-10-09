require 'pry'
require 'csv'
require_relative 'invoice_item'
#require './lib/repository'

class InvoiceItemRepository
#  include Repository

    attr_reader :filename,
                :engine,
                :read_csv,
                :all

  def initialize(engine, filename = '../data/invoice_items.csv')
    @filename = filename
    @all    ||= build_invoice_items
    @engine   = engine
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

  def find_invoice_items_by_id(id)
    all.find {|invoice_item| invoice_item.id == match }
  end



  def find_invoice_by_invoice_id(invoice_id)
    engine.find_invoice_by_invoice_id(invoice_id)
  end

  def find_item_by_invoice_id(invoice_id)
    engine.find_items_by_invoice_id(invoice_id)
  end

  def find_by(attribute, value)
    all.find { |m| m.send(attribute) == value }
  end

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
end
