require File.expand_path 'test_helper', File.dirname(__FILE__)

class HandTest < Test::Unit::TestCase
  def setup
    @ace_card   = Card.new(:hearts, :ace, [11, 1])
    @king_card  = Card.new(:hearts, :king, 10)
    @eight_card = Card.new(:hearts, :eight, 8)
    @hand       = Hand.new([@ace_card, @king_card])
  end

  def test_total_value_of_cards
    assert_equal @hand.total_value, 21
    @hand.add_card(@king_card)
    assert_equal @hand.total_value, 21
    @hand.cards = [@eight_card]
    assert_equal @hand.total_value, 8
    @hand.add_card(@ace_card)
    assert_equal @hand.total_value, 19
    @hand.add_card(@king_card)
    assert_equal @hand.total_value, 19
    @hand.add_card(@ace_card)
    assert_equal @hand.total_value, 19
  end

  def test_return_nil_if_bust
    @hand.add_card(@king_card)
    @hand.add_card(@eight_card)
    assert_equal @hand.total_value, nil
    assert_equal @hand.values, [29, 39]
  end
end