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
      result = 0
      variants = []
      @cards.each do |card|
        if card.value.is_a?(Array)
          variants << card.value
        else
          result += card.value
        end
      end
      variants.empty? ? result : variants.flatten.map{|v| sum=v+result; sum > 21 ? nil : sum}.compact.sort.last
    end
  end
end