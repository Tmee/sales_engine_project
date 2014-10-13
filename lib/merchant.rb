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

  def paid_invoices
    invoices.select do |invoice|
      invoice.transactions.any? {|t| t.result == 'success'}
    end
  end

  def revenue(date=nil)
    if date
      invoice = paid_invoices.select { |invoice| invoice.updated_at == date }
    else
      invoice = paid_invoices
    end
    invoice.inject(0) { |result, invoice| result + invoice.amount }
  end
end
