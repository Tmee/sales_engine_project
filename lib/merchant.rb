require 'date'

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :repository


  def initialize(data, repository)
    @id         = data[:id].to_i
    @name       = data[:name]
    @created_at = Date.parse(data[:created_at])
    @updated_at = Date.parse(data[:updated_at])
    @repository = repository
  end

  def items
    repository.find_items_by_id(id)
  end

  def invoices
    repository.find_invoices_by_id(id)
  end

  def invoice_items
    repository.find_invoice_items_by_merchant_id(id)
  end

  def paid_invoices
    invoices.select do |invoice|
      invoice.transactions.any? { |t| t.result == 'success' }
    end
  end

  def revenue(date=nil)
    if date
      invoices = paid_invoices.select { |invoice| invoice.updated_at == date }
    else
      invoices = paid_invoices
    end
    invoices.inject(0) { |result, invoice| result + invoice.amount }
  end

  def paid_invoice_items
    paid_invoices.map do |invoice|
      repository.engine.invoice_item_repository.find_all_by_invoice_id(invoice.id)
    end.flatten
  end

  def sold_items
    paid_invoice_items.inject(0) { |sum, item| sum += item.quantity }
  end

  def customers
    paid_invoices.map { |invoice| invoice.customer }
  end

  def favorite_customer
    customers.group_by { |item| item }.values.max_by(&:size).first
  end

  def customers_with_pending_invoices
    invoices.reject { |i| i.successful? }.map do |invoice|
      repository.find_all_by_customer_id(invoice.customer_id)
    end.flatten
  end
end

