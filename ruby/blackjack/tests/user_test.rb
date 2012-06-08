require File.expand_path 'test_helper', File.dirname(__FILE__)

class UserTest < Test::Unit::TestCase
  def setup
    @ace_card   = Card.new(:hearts, :ace, [11, 1])
    @king_card  = Card.new(:hearts, :king, 10)
    @eight_card = Card.new(:hearts, :eight, 8)
    hand = Hand.new([@ace_card, @eight_card])
    @user = User.new(hand)
  end

  def test_user_can_take_cards_to_hand
    assert_false @user.hand.nil?
    @user.take_card @ace_card
  end

  def test_user_show_cards
    assert_equal @user.show_cards, [@ace_card, @eight_card]
  end

  def test_user_finished
    assert_false @user.finished?
    user = User.new(Hand.new([@king_card, @king_card]))
    assert_false user.finished?
    user.take_card(@king_card)
    assert_true user.finished?
  end

  def test_if_user_finished_it_cannot_take_card
    assert_false @user.finished?
    assert_true @user.take_card(@king_card)
    assert_true @user.take_card(@king_card)
    assert_false @user.take_card(@king_card)
  end

  def test_want_more
    assert_equal @user.hand.total_value, 19
    assert_equal @user.hand.values.first, 9
    assert_true @user.want_more?
  end
end
