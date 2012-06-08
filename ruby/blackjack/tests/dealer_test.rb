require File.expand_path 'test_helper', File.dirname(__FILE__)

class DealerTest < Test::Unit::TestCase
  def setup
    @ace_card   = Card.new(:hearts, :ace, [11, 1])
    @king_card  = Card.new(:hearts, :king, 10)
    @eight_card = Card.new(:hearts, :eight, 8)
    hand = Hand.new([@ace_card, @king_card])
    @dealer = Dealer.new(hand)
  end

  def test_user_can_take_cards_to_hand
    assert_false @dealer.hand.nil?
    @dealer.take_card @ace_card
  end

  def test_dealer_show_only_first_card
    assert_equal @dealer.show_cards, @ace_card
  end

  def test_dealer_stays_on_17
    @dealer.hand.cards = [@ace_card, @eight_card]
    assert_true @dealer.finished?

    @dealer.hand.cards = [@eight_card]
    assert_false @dealer.finished?
  end

end
