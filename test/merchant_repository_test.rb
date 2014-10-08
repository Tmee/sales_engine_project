gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'


class MerchantRepositoryTest < Minitest::Test
  attr_reader :test_data

  def setup
    @test_data = MerchantRepository.new('./data/test_data/merchant_test_data.csv')
  end

  def test_all_loads_merchant
    first_merchant = test_data.all.first
    last_merchant  = test_data.all.last
    assert_equal '1', first_merchant.id
    assert_equal '15', last_merchant.id
    assert_equal 'Schroeder-Jerde', first_merchant.name
    assert_equal 'Adams-Kovacek', last_merchant.name
  end

  def test

  end

end
