module Blackjack
  class Card
    attr_accessor :suite, :name, :value

    def initialize(suite, name, value)
      @suite, @name, @value = suite, name, value
    end

    def min_value
      @value.is_a?(Array) ? @value.min : @value
    end
  end
end
