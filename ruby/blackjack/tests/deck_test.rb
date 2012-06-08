require File.expand_path 'test_helper', File.dirname(__FILE__)

class DeckTest < Test::Unit::TestCase
  def setup
    @deck = Deck.new
  end

  def test_new_deck_has_52_playable_cards
    assert_equal @deck.playable_cards.size, 52
  end

  def test_dealt_card_should_not_be_included_in_playable_cards
    card = @deck.deal_card
    assert_not_include @deck.playable_cards, card
  end

  def test_shuffled_deck_has_52_playable_cards
    @deck.shuffle
    assert_equal @deck.playable_cards.size, 52
  end

  def test_deal_cards_to_player_and_dealer
    @deck.deal_cards
    assert_equal @deck.players.size, 2
    assert_not_nil @deck.dealer
    assert_equal @deck.playable_cards.size, 46

    assert_equal @deck.dealer.hand.cards.size, 2
    assert_equal @deck.players.first.hand.cards.size, 2
  end

  def test_after_game_should_show_cards
    @deck.game!
    @deck.players.each do |player|
      assert_true player.finished?
    end
  end
  #
  #def test_blackjack_game_win_immediately
  #  ace_card   = Card.new(:hearts, :ace, [11, 1])
  #  king_card  = Card.new(:hearts, :king, 10)
  #  eight_card = Card.new(:hearts, :eight, 8)
  #
  #  Player.any_instance.stubs(:want_more?).returns(true)
  #  @deck.stubs(:deal_card).returns(ace_card, ace_card, king_card, king_card)
  #
  #  @deck.game!
  #
  #  assert_equal @deck.players.first, @deck.winner
  #end
  #
  #def test_bust_game_lose_immediately
  #  ace_card   = Card.new(:hearts, :ace, [11, 1])
  #  king_card  = Card.new(:hearts, :king, 10)
  #  eight_card = Card.new(:hearts, :eight, 8)
  #
  #  @deck.stubs(:deal_card).returns(king_card, king_card, king_card, king_card)
  #  @deck.game!
  #
  #  assert_equal @deck.players.first.finished?, true
  #end
  #
end
