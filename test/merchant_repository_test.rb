gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
# require 'simplecov'
# SimpleCov.start
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repo,
              :engine

  def setup
    @engine = Minitest::Mock.new
    @merchant_repo = MerchantRepository.new(engine, './test/fixtures/merchants.csv')
  end

  def test_it_exists
    assert merchant_repo
  end

  def test_it_has_a_sales_engine
    assert merchant_repo.engine
  end

  def test_it_delegates_items_to_sales_engine
    engine.expect(:find_items_by_merchant_id,[],['1'])
    merchant_repo.find_items_by_id('1')
    engine.verify
  end

  def test_return_all
    assert merchant_repo.all
    merchant = merchant_repo.all.first
    assert_equal "Schroeder-Jerde", merchant.name
    assert_equal  1, merchant.id
  end

  def test_it_returns_one_merchant_by_name
    merchant = merchant_repo.find_by_name("Bernhard-Johns")
    assert_equal 7, merchant.id
  end

  def test_it_does_not_find_nonexistant_merchant
    merchant = merchant_repo.find_by_name("Rachel")
    assert_equal nil, merchant
  end

  def test_it_returns_merchant_by_id
    merchant = merchant_repo.find_by_id(1)
    assert_equal "Schroeder-Jerde", merchant.name
  end

end
