gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'date'
# require 'simplecov'
# SimpleCov.start
require_relative '../lib/invoice'


class InvoiceTest < Minitest::Test
  attr_reader :invoice,
              :repository

  def setup
    attribute  = { id: "1",
                   customer_id: "1".to_i,
                   merchant_id: "26".to_i,
                   status: "shipped",
                   created_at: "2012-03-27 14:53:00 UTC",
                   updated_at: "2012-03-27 14:53:59 UTC" }
    @repository = Minitest::Mock.new
    @invoice    = Invoice.new(attribute, repository)
  end

  def test_it_exists
    assert Invoice
  end

  def test_it_has_a_repository
    assert invoice.repository
  end

  def test_it_assigns_correct_attributes
    assert_equal 1, invoice.id
    assert_equal 26, invoice.merchant_id
    assert_equal Date.parse("2012-03-27 14:53:00 UTC"), invoice.created_at
    assert_equal Date.parse("2012-03-27 14:53:59 UTC"), invoice.updated_at
  end

  def test_it_delegates_items_to_repository
    repository.expect(:find_customer_by_customer_id, [], [1])
    invoice.customer
    repository.verify
  end

  def test_it_can_find_transactions_by_invoice_id
    repository.expect(:find_transactions_by_invoice_id, [1].first, [1])
    assert_equal 1, invoice.transactions
  end


end
