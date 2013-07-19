require 'rss'
require 'open-uri'

#url = 'http://www.hotnews.ro/rss/'
url = 'http://news.nationalgeographic.com/index.rss'
#url = 'http://theverge.com/index.rss'

start = Time.now

etag = ""
lastM = ""

dateTime = DateTime.now

lastM = dateTime + Rational( 48 , 24 )

open(url ) do |rss|
	feed = RSS::Parser.parse(rss)

	puts feed.items.count
	puts "Title: #{feed.channel.title}"
	feed.items.each do |item|
	  puts "Item: #{item.title}"
	  puts "#{item.link}"
	  puts "#{item.description}"
	  puts "#{item.pubDate}"
	  puts "#{item.category}"
	  puts
	end
end
puts "Duration: " + (Time.now - start).to_s