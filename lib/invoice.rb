require 'date'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, repository)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status]
    @created_at  = Date.parse(data[:created_at])
    @updated_at  = Date.parse(data[:updated_at])
    @repository  = repository
  end

  def transactions
    repository.find_transactions_by_invoice_id(id)
  end

  def invoice_items
    repository.find_invoice_items_by_id(id)
  end

  def items
    repository.find_items_by_id_within_invoice_items(id)
  end

  def customer
    repository.find_customer_by_customer_id(customer_id)
  end

  def merchant
    repository.find_merchant_by_merchant_id(merchant_id)
  end

  def successful_transaction?
    transactions.any? { |t| t.result == "success" }
  end

  def successful?
     transactions.any? {|t| t.result == 'success'}
  end

  def amount
    invoice_items.inject(0) do |result, invoice_item|
      result + (BigDecimal(invoice_item.quantity) * invoice_item.unit_price)
    end
  end
end