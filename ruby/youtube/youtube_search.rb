require 'json'
require 'cgi'
require 'open-uri'

class YoutubeSearch
  def self.search(query, opts={})
    options = {:'max-results' => 3, q: query}.merge(opts)
    _query = options.map{|k,v| "#{CGI.escape k.to_s}=#{CGI.escape v.to_s}" }.join('&')
    url = "https://gdata.youtube.com/feeds/api/videos?#{_query}&v=2&alt=json"
    extract_video_links JSON.parse(open(url).read)
  end
  
  def self.extract_video_links(response)
    response["feed"]["entry"].map{|entry| entry["link"].first["href"] }
  end
end