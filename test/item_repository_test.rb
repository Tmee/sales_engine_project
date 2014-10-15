gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository'


class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repo,
              :engine


  def setup
    @engine    = Minitest::Mock.new
    @item_repo = ItemRepository.new(engine, './test/fixtures/items.csv')
  end

  def test_it_exists
    assert item_repo
  end

  def test_it_has_a_sales_engine
    assert item_repo.engine
  end


  def test_it_delegates_items_to_sales_engine
    engine.expect(:find_by_merchant_id,[],['1'])
    item_repo.find_merchant_by_id('1')
    engine.verify
  end

  def test_it_finds_the_most_revenue

  end

  def test_it_finds_all_by_unit_price
    results = item_repo.find_all_by_unit_price(BigDecimal('751.07'))
    assert_equal results[0].id, 1

    results = item_repo.find_all_by_unit_price(BigDecimal('751.07'))
    refute_equal results[0].id, 2
  end
end