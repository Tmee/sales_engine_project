require 'pry'
require 'date'
class Customer
  attr_reader :repository,
              :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(data, repository)
    @id         = data[:id].to_i
    @first_name = data[:first_name]
    @last_name  = data[:last_name]
    @created_at = Date.parse(data[:created_at])
    @updated_at = Date.parse(data[:updated_at])
    @repository = repository
  end

  def invoices
    repository.find_invoices_by_customer_id(id)
  end

end
