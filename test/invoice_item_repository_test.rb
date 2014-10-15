gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :invoice_item_repo,
              :engine

  def setup
    @engine = Minitest::Mock.new
    @invoice_item_repo = InvoiceItemRepository.new(engine, './test/fixtures/invoice_items.csv')
  end

  def test_it_exists
    assert invoice_item_repo
  end

  def test_it_has_a_sales_engine
    assert invoice_item_repo.engine
  end

  def test_it_delegates_items_to_sales_engine
    engine.expect(:find_invoice_by_invoice_id,[],[1])
    invoice_item_repo.find_by_item_id(1)
    engine.verify
  end

  def test_return_all
    assert invoice_item_repo.all
    invoice_item = invoice_item_repo.all.first
    assert_equal 5, invoice_item.quantity
    assert_equal 1, invoice_item.id
  end

  def test_it_returns_invoice_item_by_id
    invoice_item = invoice_item_repo.find_by_id(6)
    assert_equal 52100, invoice_item.unit_price
  end

  def test_it_does_not_find_nonexistant_invoice_item
    invoice_item = invoice_item_repo.find_by_id("0")
    assert_equal nil, invoice_item
  end

  def test_it_returns_one_invoice_item_by_item_id
    invoice_item = invoice_item_repo.find_by_item_id(1849)
    assert_equal 2, invoice_item.invoice_id
  end

end
