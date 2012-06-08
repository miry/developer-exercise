module Blackjack
  class User
    attr_accessor :hand

    def initialize(hand)
      @hand = hand
    end
  end
end