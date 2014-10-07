gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'


class MerchantRepositoryTest < Minitest::Test

  def test_return_all
    data = [
    [ id: "1", name: "Schroeder-Jerde", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC" ],
    [ id: "2", name: "Klein, Rempel and Jones", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC" ],
    [ id: "3", name: "Willms and Sons", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC" ]
    ].map { |row| Merchant.new(row) }
    assert_equal data, Merchant.new(data)
  end

  def test_return_random
    skip
    assert
  end

end
