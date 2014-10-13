require 'date'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id         = data[:id].to_i
    @item_id    = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity   = data[:quantity].to_i
    @unit_price = BigDecimal.new(data[:unit_price])/ BigDecimal(100)
    @created_at = Date.parse(data[:created_at])
    @updated_at = Date.parse(data[:updated_at])
    @repository = repository
  end

  def invoice
    repository.find_invoice_by_invoice_id(invoice_id)
  end

  def item
    repository.find_item_by_item_id(item_id)
  end

  def transactions
    repository.find_all_by_id(invoice_id)
  end

  def successful?
    transactions.any? {|t| t.result == 'success'}
  end
end

