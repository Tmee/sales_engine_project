
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'date'
require_relative '../lib/item'

class ItemTest < Minitest::Test
  attr_reader :repository,
              :item

  def setup
    data  = {id: '1'.to_i,
              name: 'Example',
              description: 'random description',
              unit_price: '75043'.to_i,
              merchant_id: '7'.to_i,
              created_at: '2012-03-27 14:53:59 UTC',
              updated_at: '2012-03-27 14:53:59 UTC' }
    @repository = Minitest::Mock.new
    @item       = Item.new(data, repository)

  end

  def test_it_exists
    assert Item
  end

  def test_it_has_a_repository
    assert item.repository
  end

  def test_it_assigns_correct_attributes
    assert_equal 1, item.id
    assert_equal 'Example', item.name
    assert_equal BigDecimal.new('75043')/BigDecimal(100), item.unit_price
  end

  def test_it_delegates_items_to_repository
    repository.expect(:find_invoice_items_by_id, [], [1])
    item.invoice_items
    repository.verify
  end

  def test_it_finds_the_best_day
    date = Date.parse("2012-03-27")
    assert_equal date, item.best_day
  end
end
