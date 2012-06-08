module Blackjack
  class Deck
    attr_accessor :playable_cards, :players, :dealer
    NUMBER_OF_PLAYERS = 2
    SUITES = [:hearts, :diamonds, :spades, :clubs]
    NAME_VALUES = {
      :two   => 2,
      :three => 3,
      :four  => 4,
      :five  => 5,
      :six   => 6,
      :seven => 7,
      :eight => 8,
      :nine  => 9,
      :ten   => 10,
      :jack  => 10,
      :queen => 10,
      :king  => 10,
      :ace   => [11, 1]}

    def initialize
      shuffle
    end

    def deal_card
      random = rand(@playable_cards.size)
      @playable_cards.delete_at(random)
    end

    def shuffle
      @playable_cards = []
      SUITES.each do |suite|
        NAME_VALUES.each do |name, value|
          @playable_cards << Card.new(suite, name, value)
        end
      end
    end

    def deal_cards
      hands = Array.new(NUMBER_OF_PLAYERS+1) { Hand.new }
      cards = Array.new(hands.size*2) { deal_card }

      cards.zip(hands*2).each do |dealed_card|
        dealed_card.last.add_card dealed_card.first
      end

      @players = hands[0..-2].map{|hand| Player.new(hand) }
      @dealer  = Dealer.new hands.last
    end

  end
end