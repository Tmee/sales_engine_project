gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'simplecov'
SimpleCov.start
require_relative '../lib/transaction'


class TransactionTest < Minitest::Test
  attr_reader :transaction,
              :repository

  def setup
    attribute  = { id: "1".to_i,
                   invoice_id: "1".to_i,
                   credit_card_number: "4654405418249632".to_i,
                   result: "success" }
    @repository    = Minitest::Mock.new
    @transaction   = Transaction.new(attribute, repository)
  end

  def test_it_exists
    assert Transaction
  end

  def test_it_has_a_repository
    assert transaction.repository
  end

  def test_it_assigns_correct_attributes
    assert_equal 1, transaction.invoice_id
    assert_equal 1, transaction.id
    assert_equal 4654405418249632, transaction.credit_card_number
    assert_equal "success", transaction.result
  end

end
