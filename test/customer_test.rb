gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test
  attr_reader :repository,
              :customer

  def setup
    data        = { id: '1',
                    first_name: 'Joey',
                    last_name: 'Ondricka',
                    created_at: '2012-03-27 14:53:00 UTC',
                    updated_at: '2012-03-27 14:54:09 UTC' }
    @repository = Minitest::Mock.new
    @customer   = Customer.new(data, repository)
  end

  def test_it_exists
    assert Customer
  end

  def test_it_has_a_repository
    assert customer.repository
  end

  def test_it_assigns_correct_attributes
    assert_equal "1", customer.id
    assert_equal "Joey", customer.first_name
    assert_equal "Ondricka", customer.last_name
    assert_equal "2012-03-27 14:53:00 UTC", customer.created_at
    assert_equal "2012-03-27 14:54:09 UTC", customer.updated_at
  end

  def test_it_delegates_items_to_repository
    repository.expect(:find_invoices_by_customer_id, [], ["1"])
    customer.invoices
    repository.verify
  end
end
