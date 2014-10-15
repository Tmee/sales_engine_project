require 'bigdecimal'
require 'date'

class Item
    attr_reader :id,
                :name,
                :description,
                :unit_price,
                :merchant_id,
                :created_at,
                :updated_at,
                :repository

  def initialize(data, repository)
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = BigDecimal.new(data[:unit_price])/BigDecimal(100)
    @merchant_id = data[:merchant_id].to_i
    @created_at  = Date.parse(data[:created_at])
    @updated_at  = Date.parse(data[:updated_at])
    @repository  = repository
  end

  def invoice_items
    repository.find_invoice_items_by_id(id)
  end

  def paid_invoice_items
    @paid_invoice_items ||= invoice_items.select { |i| i.invoice.successful? }
  end

  def revenue
    paid_invoice_items.inject(0) { |sum, i| sum += (i.unit_price * i.quantity) }
  end

  def total_items
    paid_invoice_items.inject(0) { |sum, i| sum += i.quantity}
  end

  def merchant
    repository.find_merchant_by_merchant_id(merchant_id)
  end

  def best_day
    daily_invoice_items = paid_invoice_items.group_by do |invoice_item|
      invoice_item.invoice.updated_at
    end
    binding.pry
    daily_invoice_items.values.flatten!
    daily_item_totals = total_items_by_date(daily_invoice_items)
    daily_item_totals.max_by { |k, v| v }[0]
  end

  def total_items_by_date(invoice_items)
    invoice_items.each do |key, value|
      invoice_items[key] = value.inject(0) do |sum, invoice_item|
        sum + invoice_item.quantity
      end
    end
  end
end
