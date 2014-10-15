gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'


class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoice_repo,
              :engine

  def setup
    @engine = Minitest::Mock.new
    @invoice_repo = InvoiceRepository.new(engine, './test/fixtures/invoices.csv')
  end

  def test_it_exists
    assert invoice_repo
  end

  def test_it_has_a_sales_engine
    assert invoice_repo.engine
  end

  def test_it_delegates_items_to_sales_engine
    engine.expect(:find_invoice_by_invoice_id,[],['1'])
    invoice_repo.find_invoice_by_invoice_id("1")
    engine.verify
  end

  def test_return_all
    assert invoice_repo.all
    invoice = invoice_repo.all.first
    assert_equal "shipped", invoice.status
    assert_equal  1, invoice.id
  end

  def test_it_returns_invoice_item_by_id
    invoice = invoice_repo.find_by_id("3")
    assert_equal 78, invoice.merchant_id
  end

  def test_it_does_not_find_nonexistant_invoice_item
    invoice = invoice_repo.find_by_id("0")
    assert_equal nil, invoice
  end

  def test_it_returns_one_invoice_by_customer_id
    invoice = invoice_repo.find_by_customer_id("3")
    assert_equal "86", invoice.merchant_id
  end

  # def test_return_random
  #   skip
  #   assert
  # end

end
