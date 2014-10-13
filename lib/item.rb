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

  def merchant
    repository.find_merchant_by_merchant_id(merchant_id)
  end
end
