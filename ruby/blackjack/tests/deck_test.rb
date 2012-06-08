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
    assert(@deck.playable_cards.include?(card))
  end

  def test_shuffled_deck_has_52_playable_cards
    @deck.shuffle
    assert_equal @deck.playable_cards.size, 52
  end

  def test_show_cards_of_user_and_dealer
    @deck.deal_cards
    assert_equal @deck.players.size, 2
    assert_equal @deck.dealer.size, 1
  end
end
