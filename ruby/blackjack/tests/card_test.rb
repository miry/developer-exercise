require File.expand_path 'test_helper', File.dirname(__FILE__)

class CardTest < Test::Unit::TestCase
  def setup
    @card = Card.new(:hearts, :ten, 10)
  end
  
  def test_card_suite_is_correct
    assert_equal @card.suite, :hearts
  end

  def test_card_name_is_correct
    assert_equal @card.name, :ten
  end

  def test_card_value_is_correct
    assert_equal @card.value, 10
  end

  def test_card_ace_can_be_1_or_11
    ace_card = Card.new(:hearts, :ace, [11, 1])
    assert_equal ace_card.value, [11, 1]
  end

  def test_min_value_of_ace
    ace_card = Card.new(:hearts, :ace, [11, 1])
    assert_equal ace_card.min_value, 1
  end
end
