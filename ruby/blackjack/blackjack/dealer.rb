module Blackjack
  class Dealer < User

    def show_cards
      super.first
    end
  end
end