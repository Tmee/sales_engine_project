gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customer_repo,
              :engine

  def setup
    @engine        = Minitest::Mock.new
    @customer_repo = CustomerRepository.new(engine, './test/fixtures/customers.csv')
  end

  def test_it_exists
    assert customer_repo
  end

  def test_it_has_a_sales_engine
    assert customer_repo.engine
  end

  def test_it_delegates_items_to_sales_engine
    engine.expect(:find_invoices_by_customer_id,[],['1'])
    customer_repo.find_invoices_by_customer_id('1')
    engine.verify
  end

  def test_return_all
    assert customer_repo.all
    customer = customer_repo.all.first
    assert_equal "Joey", customer.first_name
    assert_equal  1, customer.id
  end

  def test_it_returns_one_customer_by_name
    customer = customer_repo.find_by_first_name("Parker")
    assert_equal "Parker", customer.first_name
  end

  def test_it_does_not_find_nonexistant_customer
    customer = customer_repo.find_by_first_name("Rachel")
    assert_equal nil, customer
  end

end
