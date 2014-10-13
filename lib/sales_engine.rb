require_relative 'require_helper'

class SalesEngine
  attr_reader :merchant_repository,
              :invoice_repository,
              :item_repository,
              :invoice_item_repository,
              :customer_repository,
              :transaction_repository,
              :data

  def initialize(data = "./csvs")
    @data = data
  end

  def startup
    @merchant_repository     = MerchantRepository.new(self, './csvs/merchants.csv')
    @invoice_repository      = InvoiceRepository.new(self, './csvs/invoices.csv')
    @item_repository         = ItemRepository.new(self, './csvs/items.csv')
    @invoice_item_repository = InvoiceItemRepository.new(self, './csvs/invoice_items.csv')
    @customer_repository     = CustomerRepository.new(self, './csvs/customers.csv')
    @transaction_repository  = TransactionRepository.new(self, './csvs/transactions.csv')
  end

  def find_items_by_merchant_id(merchant_id)
    item_repository.find_all_by_merchant_id(merchant_id)
  end

  def find_invoice_items_by_id(invoice_id)
    invoice_item_repository.find_all_by_invoice_id(invoice_id)
  end

  def find_invoice_items_by_id(id)
    invoice_item_repository.find_all_by_item_id(id)
  end

  def find_by_merchant_id(id)
    merchant_repository.find_by_merchant_id(id)
  end

  def find_invoices_by_customer_id(id)
    invoice_repository.find_all_by_customer_id(id)
  end

  def find_invoices_by_merchant_id(id)
    invoice_repository.find_all_by_merchant_id(id)
  end

  def find_invoice_by_invoice_id(id)
    invoice_repository.find_by_id(id)
  end

  def find_by_item_id(id)
    item_repository.find_by_id(id)
  end

  def find_invoice_by_invoice_id(invoice_id)
    invoice_repository.find_by_id(invoice_id)
  end

  def find_item_by_item_id(item_id)
    item_repository.find_by_id(item_id)
  end

  def find_customer_by_customer_id(id)
    customer_repository.find_by_id(id)
  end

  def find_transactions_by_id(id)
    transaction_repository.find_by_id(id)
  end

  def find_items_by_id_within_invoice_items(invoice_id)
    invoice_items = invoice_item_repository.find_all_by_invoice_id(invoice_id)
    invoice_items.map { |ii| item_repository.find_by_id(ii.item_id) }
  end

  def find_transactions_by_invoice_id(invoice_id)
    transaction_repository.find_all_by_invoice_id(invoice_id)
  end
end
