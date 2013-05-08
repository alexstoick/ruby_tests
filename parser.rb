# encoding: UTF-8
require 'nokogiri'
require 'open-uri'
require 'json'

#page = Nokogiri::HTML(open('http://www.cinemagia.ro/program-cinema/bucuresti/'))
page = Nokogiri::HTML(open('shit.html'))

json = []
movies = page.css(".program_cinema_show")
puts movies.length
j = 0
for k in 0..(movies.length-1) do
	film = movies[k]
	titluRo = film.css(".title_ro").text
	titluEn = film.css("h2:first").text
	details = film.css(".info")[0]

	nota = details.css("div")[0].text
	gen = details.css("div")[1].text
	actori = details.css("div")[2].text
	#regizor = details.css("div")[3].text

	gen = gen.gsub( /\s\s+/ , '' )
	actori = actori.gsub( /\s\s+/ , '' )
	#regizor = regizor.gsub( /\s\s+/ , '' )

	cinematografe = film.css(".mb5")

	cinematografe.each do |cinematograf|
		cinemaName = cinematograf.css(".theatre-link")[0].text

		#buy_ticket_hour
		#show_hour_price_info
		# added = 0
		# program = cinematograf.css(".buy_ticket_hour")
		# program.each do |ora|
		# 	ora = ora.text
		# 	added += 1
		# 	puts ora
		# end

		# program = cinematograf.css(".show_hour_price_info")
		# program.each do |ora|
		# 	ora = ora.text
		# 	added += 1
		# 	puts ora
		# end
		# if ( added = 0 )
		# 	program = film.css(".show_hour_price_info")
		# end
		# program.each do |ora|
		# 	ora = ora.text
		# 	added += 1
		# 	puts ora
		# end
		# puts k.to_s + " " + cinemaName + " " + program.length.to_s

		# program = cinematograf.css("div")[0].text
		# puts k.to_s + " entered"
		# program = program.gsub(/[^0-9:]/i, '')
		# length = (program.length)/5
		# for i in 0..length do
		# 	ora = program[i*5 , 5 ]
		# 	j = j + 1
		# 	intrare = {}
		# 	intrare [ "id" ] = j
		# 	intrare [ "titluEn" ] = titluEn
		# 	intrare [ "titluRo" ] = titluRo
		# 	intrare [ "cinema" ] = cinemaName
		# 	intrare [ "ora" ] = ora ;
		# 	intrare [ "nota" ] = nota ;
		# 	intrare [ "gen" ] = gen ;
		# 	intrare [ "actori" ] = actori ;
		# 	#intrare [ "regizor" ] = regizor ;
		# 	json.push ( intrare )
		# end
	end
end


completeJSON = {}
completeJSON["movies"] = json
completeJSON["updated"] = Time.now.to_s

generatedJSON = JSON.generate( completeJSON )

File.open( 'date.json', 'w' ) { |file| file.write( generatedJSON ) }