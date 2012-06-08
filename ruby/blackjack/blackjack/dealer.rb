module Blackjack
  class Dealer < User

    def show_cards
      super.first
    end

    def finished?
      super || @hand.total_value > 17
    end
  end
end