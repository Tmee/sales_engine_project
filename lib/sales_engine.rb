#require_relative 'require_helper'


class SalesEngine
  attr_reader :merchant_repository,
              :invoice_repository,
              :item_repository,
              :invoice_item_repository,
              :customer_repository,
              :transaction_repository

  def initialize(data = "./data")
    @data = data
  end

  def startup
    @merchant_repository     = MerchantRepository.new(nil, self)
    @invoice_repository      = InvoiceRepository.new(nil, self)
    @item_repository         = ItemRepository.new(nil, self)
    @invoice_item_repository = InvoiceItemRepository.new(nil, self)
    @customer_repository     = CustomerRepository.new(nil, self)
    @transaction_repository  = TransactionRepository.new(nil, self)
  end

  def find_items_by_merchant_id(id)
    item_repository.find_by_merchant(id)
  end

  def find_invoice_items_by_id(id)
    invoice_item_repository.find_invoice_items_by_id(id)
  end

  def find_merchant_by_id(id)
    merchant_repository.find_merchant_by_id(id)
  end

  def find_invoice_by_customer_id(id)
    invoice_repository.find_invoice_by_customer_id(id)
  end


  def find_invoices_by_merchant_id(id)
    invoice_repository.find_by_merchant(id)
  end

  def find_invoice_by_invoice_id(id)
    invoice_repository.find_by_invoice_id(id)
  end

  def find_items_by_invoice_id(id)
    item_repository.find_by_invoice_id(id)
  end

end
