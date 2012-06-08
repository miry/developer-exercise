module Blackjack
  class User
    attr_accessor :hand, :deck

    def initialize(hand)
      @hand = hand
      @finished = false
      @deck = nil
    end

    def take_card(card)
      return false if finished?
      @hand.add_card(card)
      true
    end

    def show_cards
      @hand.cards
    end

    def cards_count
      @hand.cards.size
    end

    def finished?
      @finished ||= @hand.blackjack? || @hand.bust?
    end

    def finished!
      @finished = true
    end

    def want_more?
      return true if @hand.total_value <= 11 || @hand.values.first <= 11
      need_value = 21 - @hand.total_value

      own_cards_count = @hand.cards.select { |card| card.min_value <= need_value }.size
      left_count      = (need_value * 4) - own_cards_count
      return true if left_count / (Deck::NUMBER_OF_CARDS - @hand.cars.size) > 0.7
      return true if need_value <= rand(9) #good luck

      false
    end


  end
end