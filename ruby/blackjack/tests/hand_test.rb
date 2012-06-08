require File.expand_path 'test_helper', File.dirname(__FILE__)

class HandTest < Test::Unit::TestCase
  def setup
    @ace_card = Card.new(:hearts, :ace, [11, 1])
    @king_card = Card.new(:hearts, :king, 10)
    @hand = Hand.new([@ace_card, @king_card])
  end

  def test_total_value_of_cards
    assert_equal @hand.total_value, 21
    @hand.add_card(@king_card)
    assert_equal @hand.total_value, 21
  end
end