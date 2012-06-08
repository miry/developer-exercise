module Blackjack
  class Dealer < User

    def show_cards
      super || [@hand.cards.first]
    end

    def finished?
      @finished ||= super || @hand.total_value > 17
    end

  end
end