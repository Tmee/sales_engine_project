gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'


class MerchantTest < Minitest::Test
  attr_reader :merchant,
              :repository

  def setup
    attribute  = { id: "1",
                   name: "Example",
                   created_at: "2012-03-27 14:53:00 UTC",
                   updated_at: "2012-03-27 14:53:59 UTC" }
    @repository = Minitest::Mock.new
    @merchant   = Merchant.new(attribute, repository)
  end

  def test_it_exists
    assert Merchant
  end

  def test_it_has_a_repository
    assert merchant.repository
  end

  def test_it_assigns_correct_attributes
    assert_equal "1", merchant.id
    assert_equal "Example", merchant.name
    assert_equal "2012-03-27 14:53:00 UTC", merchant.created_at
    assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
  end

  def test_it_delegates_items_to_repository
    repository.expect(:find_items_by_id, [], ["1"])
    merchant.items
    repository.verify
  end
end