require 'test/unit'
require File.expand_path('./youtube_search.rb', File.dirname(__FILE__))

class YoutubeSearchTest < Test::Unit::TestCase
  def setup
    # subject = YoutubeSearch.new
  end
  
  def test_has_method_to_search
    assert_respond_to(YoutubeSearch, :search)
  end
  
  def test_find_google_developers_video
    result = YoutubeSearch.search("Google")
    assert_equal 3, result.size
    assert_not_nil result.first =~ /https:\/\/www.youtube.com\/watch\?v\=/
  end
  
  def test_with_empty_attribute
    assert_equal 3, YoutubeSearch.search(nil).size
  end
end