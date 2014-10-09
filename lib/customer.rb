class Customer
  attr_reader :repository,
              :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(data, repository)
    @id         = data[:id]
    @first_name = data[:first_name]
    @last_name  = data[:last_name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = repository
  end

  def invoices
    repository.find_invoice_by_customer_id(id)
  end

end