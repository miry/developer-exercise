module Blackjack
  class Deck
    attr_accessor :playable_cards, :players, :dealer, :winner
    NUMBER_OF_PLAYERS = 2
    NUMBER_OF_CARDS = 52
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

      cards.zip(hands*2).each do |hand_with_card|
        hand_with_card.last.add_card hand_with_card.first
      end

      @dealer  = Dealer.new hands.pop
      @players = hands.map{|hand| Player.new(hand) }

      @players.each do |player|
        break if check_winner player
      end
    end

    def check_winner player
      if player.hand.blackjack?
        @winner = player
        return true
      end
      false
    end

    def game!
      deal_cards
      @players.each do |player|
        break if player_take_cards(player)
      end if @winner.nil?

      @winner ||= player_take_cards(@dealer)
      @winner ||= find_winner_by_values
      @players.each(&:finished!)
      @winner
    end

    def player_take_cards(player)
      player.take_card(deal_card) while !player.finished? && player.want_more?
      check_winner(player)
    end

    def find_winner_by_values
      winners = [@dealer]
      @players.each do |user|
        next if user.finished?
        winner_value = winners.first.hand.total_value
        winners = [user] if winner_value < user.hand.total_value
        winners << user if winner_value == user.hand.total_value
      end
      winners
    end

  end
end