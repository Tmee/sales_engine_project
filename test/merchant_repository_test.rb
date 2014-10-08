gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'


class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repo,
              :engine

  def setup
    @engine = []
    @merchant_repo = MerchantRepository.new(engine, './test/fixtures/merchants.csv')
  end

  def test_it_exists
    assert merchant_repo
  end

  def test_it_has_a_sales_engine
    assert merchant_repo.engine
  end

  def test_it_delegates_items_to_sales_engine
    skip
    engine.expect(:find_items_from_merchant,[],['1'])
    merchant_repo.find_items_from('1')
    engine.verify
  end

  def test_return_all
    assert merchant_repo.all
    merchant = merchant_repo.all.first
    assert_equal "Schroeder-Jerde", merchant.name
    assert_equal  '1', merchant.id
  end

  def



  def test_return_random
    skip
    assert
  end

end
