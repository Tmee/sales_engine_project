require_relative 'require_helper'

class SalesEngine
  attr_reader :merchant_repository,
              :invoice_repository,
              :item_repository,
              :invoice_item_repository,
              :customer_repository,
              :transaction_repository,
              :d,:m,:iv,:it,:ii,:c,:t


  def initialize(data = "./csvs")
    @d  = data
    @m  = "merchants"
    @iv = "invoices"
    @it = "items"
    @ii = "invoice_items"
    @c  = "customers"
    @t  = "transactions"
  end

  def startup
    @merchant_repository     = MerchantRepository.new(self, "#{d}/#{m}.csv")
    @invoice_repository      = InvoiceRepository.new(self, "#{d}/#{iv}.csv")
    @item_repository         = ItemRepository.new(self, "#{d}/#{it}.csv")
    @invoice_item_repository = InvoiceItemRepository.new(self, "#{d}/#{ii}.csv")
    @customer_repository     = CustomerRepository.new(self, "#{d}/#{c}.csv")
    @transaction_repository  = TransactionRepository.new(self, "#{d}/#{t}.csv")
  end

  def create_transaction(data)
    transaction_repository.create_transaction(data)
  end

  def create_items(items, id, time)
    invoice_item_repository.create_items(items, id, time)
  end

  def find_all_by_customer_id(customer_id)
    customer_repository.find_all_by_id(customer_id)
  end

  def find_all_invoices_by_invoice_id(id)
    invoice_repository.find_all_by_id(id)
  end

  def find_items_by_merchant_id(merchant_id)
    item_repository.find_all_by_merchant_id(merchant_id)
  end

  def find_invoice_items_by_id(invoice_id)
    invoice_item_repository.find_all_by_invoice_id(
      invoice_id)
  end

  def find_invoice_items_by_item_id(item_id)
    invoice_item_repository.find_all_by_item_id(item_id)
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

    # def find_invoice_by_invoice_id(id)
    #   invoice_repository.find_by_id(id)
    # end

  def find_by_item_id(id)
    item_repository.find_by_id(id)
  end

  def find_invoice_by_invoice_id(invoice_id)
    invoice_repository.find_by_id(invoice_id)
  end

  def find_item_by_item_id(id)
    item_repository.find_by_id(id)
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

  def find_transactions_by_customer_id_via_invoices(customer_id)
    invoices = invoice_repository.find_all_by_customer_id(customer_id)
    invoices.map { |i| transaction_repository.find_by_invoice_id(i.id) }
  end

  def find_merchant_ids_for(customer_id)
    invoice_repository.find_all_by_customer_id(customer_id)
                      .select(&:successful_transaction?)
                      .collect(&:merchant_id)
  end

  def find_favorite_merchant(customer_id)
    merchant_id = find_merchant_ids_for(customer_id)
    .group_by { |merchant| merchant }
    .max_by { |k, v| v.count }.first
    merchant_repository.find_by_id(merchant_id)
  end

end
