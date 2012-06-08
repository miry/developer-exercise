module Blackjack
  class User
    attr_accessor :hand

    def initialize(hand)
      @hand = hand
    end

    def take_card(card)
      @hand.add_card(card)
    end

    def show_cards
      @hand.cards
    end

    def finished?
      @hand.blackjack? || @hand.bust?
    end
  end
end