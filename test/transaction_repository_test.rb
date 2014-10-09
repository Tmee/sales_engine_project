gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/transaction_repository'


class TransactionRepositoryTest < Minitest::Test
  attr_reader :transaction_repo,
              :engine

  def setup
    @engine = Minitest::Mock.new
    @transaction_repo = TransactionRepository.new(engine, './test/fixtures/transactions.csv')
  end

  def test_it_exists
    assert transaction_repo
  end

  def test_it_has_a_sales_engine
    assert transaction_repo.engine
  end

  def test_it_delegates_items_to_sales_engine
    engine.expect(:find_items_by_invoice_id,[],['1'])
    transaction_repo.find_items_by_invoice_id("1")
    engine.verify
  end

  def test_return_all
    assert transaction_repo.all
    transaction = transaction_repo.all.first
    assert_equal "success", transaction.result
    assert_equal  '1', transaction.id
  end

  def test_it_returns_invoice_item_by_id
    transaction = transaction_repo.find_by_id("4")
    assert_equal "4515551623735607", transaction.credit_card_number
  end

  def test_it_does_not_find_nonexistant_invoice_item
    transaction = transaction_repo.find_by_id("0")
    assert_equal nil, transaction
  end

  def test_it_returns_one_transaction_by_credit_card_number
    transaction = transaction_repo.find_by_credit_card_number("4203696133194408")
    assert_equal "7", transaction.invoice_id
  end

  def test_return_random
    skip
    assert
  end

end
