gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'date'
# require 'simplecov'
# SimpleCov.start
require_relative '../lib/merchant'


class MerchantTest < Minitest::Test
  attr_reader :merchant,
              :repository

  def setup
    attribute  = { id: "1".to_i,
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
    assert_equal 1, merchant.id
    assert_equal "Example", merchant.name
    assert_equal Date.parse("2012-03-27 14:53:00 UTC"), merchant.created_at
    assert_equal Date.parse("2012-03-27 14:53:59 UTC"), merchant.updated_at
  end


end
