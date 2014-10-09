gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_item'


class InvoiceItemTest < Minitest::Test
  attr_reader :invoice_item,
              :repository

  def setup
    attribute  = { id: "1",
                   item_id: "539",
                   invoice_id: "1",
                   created_at: "2012-03-27 14:53:00 UTC",
                   updated_at: "2012-03-27 14:53:59 UTC" }
    @repository = Minitest::Mock.new
    @invoice_item   = InvoiceItem.new(attribute, repository)
  end

  def test_it_exists
    assert InvoiceItem
  end

  def test_it_has_a_repository
    assert invoice_item.repository
  end

  def test_it_assigns_correct_attributes
    assert_equal "1", invoice_item.id
    assert_equal "539", invoice_item.item_id
    assert_equal "2012-03-27 14:53:00 UTC", invoice_item.created_at
    assert_equal "2012-03-27 14:53:59 UTC", invoice_item.updated_at
  end

  def test_it_delegates_items_to_repository
    repository.expect(:find_item_by_invoice_id, [], ["1"])
    invoice_item.item
    repository.verify
  end


end
