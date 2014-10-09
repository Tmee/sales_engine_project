gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item_repository'


class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repo,
              :engine


  def setup
    @engine = Minitest::Mock.new
    @item_repo = ItemRepository.new(engine, './test/fixtures/items.csv')
  end

  def test_it_exists
    assert item_repo
  end

  def test_it_has_a_sales_engine
    assert item_repo.engine
  end


  def test_it_delegates_items_to_sales_engine
    engine.expect(:find_merchant_by_id,[],['1'])
    item_repo.find_merchant_by_id('1')
    engine.verify
  end



end