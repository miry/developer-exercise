require File.expand_path 'test_helper', File.dirname(__FILE__)

class UserTest < Test::Unit::TestCase
  def setup
    @user = User.new
  end

  def test_user_can_take_cards_to_hand
    @user
  end

end
