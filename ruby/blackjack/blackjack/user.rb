module Blackjack
  class User
    attr_accessor :hand

    def initialize(hand)
      @hand = hand
      @finished = false
    end

    def take_card(card)
      return false if finished?
      @hand.add_card(card)
      finished?
      true
    end

    def show_cards
      @hand.cards if finished?
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

      known_cards_count = @hand.cards.select { |card| card.min_value <= need_value }.size
      known_cards_count += 1 if @deck && @deck.dealer.show_cards.first.min_value <= need_value
      left_needed_cards_count = (need_value * 4) - known_cards_count
      return true if left_needed_cards_count / (Deck::NUMBER_OF_CARDS - @hand.cards.size) > 0.7
      return true if need_value > 5+rand(4) || rand(100) > 90 #good luck

      false
    end


  end
end