gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'


class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repo

  def setup
    engine = []
    @merchant_repo = MerchantRepository.new(engine, './test/fixtures/merchants.csv')
  end

  def test_it_exists
    assert merchant_repo
  end

  def test_return_all
    assert merchant_repo.all.is_a?(Array)
    merchant = merchant_repo.all.first
    assert merchant.is_a?(Merchant)
    assert_equal "Schroeder-Jerde", merchant.name
    # data = [
    # { id: "1", name: "Schroeder-Jerde", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC" },
    # { id: "2", name: "Klein, Rempel and Jones", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC" },
    # { id: "3", name: "Willms and Sons", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC" }
    # ].map { |row| Merchant.new(row) }
    # assert_equal data, Merchant.new(data)
  end

  def test_return_random
    skip
    assert
  end

end
