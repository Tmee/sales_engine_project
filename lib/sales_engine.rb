require_relative 'require_helper'


class SalesEngine
  attr_reader :merchant_repository,
              :invoice_repository,
              :item_repository,
              :invoice_item_repository,
              :customer_repository,
              :transaction_repository

  def initialize
  end

  def startup
    @merchant_repository = MerchantRepository.new(nil)
    @invoice_repository  = InvoiceRepository.new(nil)
    @item_repository     = ItemRepository.new(nil)
    @invoice_item_repository = InvoiceItemRepository.new(nil)
    @customer_repository     = CustomerRepository.new(nil)
    @transaction_repository  = TransactionRepository.new(nil)
  end

  def find_items_by_merchant_id(id)
    item_repository.find_by_merchant(id)
  end
end