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
  end
end