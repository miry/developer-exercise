module Blackjack
  class Hand
    attr_accessor :cards

    def initialize(cards=[])
      @cards = cards
    end

    def add_card(card)
      @cards << card
    end

    def total_value
      values.select{|value| value<=21}.last
    end

    def values
      result   = 0
      variants = []
      @cards.each do |card|
        if card.value.is_a?(Array)
          variants << card.value
        else
          result += card.value
        end
      end
      variants.empty? ? [result] : variants.flatten.map{|v| v+result }.sort
    end

    def blackjack?
      total_value == 21
    end

    def bust?
      total_value.nil?
    end
  end
end