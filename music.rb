# encoding: UTF-8
require 'nokogiri'
require 'open-uri'

link = "http://jog.fm/workout-songs?page="

list = []

for i in 1..2 do


	page = Nokogiri::HTML(open(link+ i.to_s))

	page.css(".song").each do |song|

		band = song.css(".top").text
		title = song.css(".title").text
		if ! (band.empty? or title.empty? )
			list.push ( band + " - " + title )
		end
	end
end

File.open( 'music.json', 'w' , encoding: 'ISO-8859-1' ) { |file| list.each do |entry| file.puts ( entry ) end }