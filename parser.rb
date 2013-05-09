# encoding: UTF-8
require 'nokogiri'
require 'open-uri'
require 'json'

page = Nokogiri::HTML(open('http://www.cinemagia.ro/program-cinema/bucuresti/'))
#page = Nokogiri::HTML( "<img src='333.htmlqq' />")
#page = Nokogiri::HTML(open('shit.html'))

json = []
movies = page.css(".program_cinema_show")
j = 0
for k in 0..(movies.length-1) do
	film = movies[k]

	img = film.css("img")[0]["src"]
	titluRo = film.css(".title_ro").text
	titluEn = film.css("h2:first").text
	details = film.css(".info")[0]

	if ( details.css("div").length < 4 )
		next
	end

	nota = details.css("div")[0].text
	gen = details.css("div")[1].text
	actori = details.css("div")[2].text
	regizor = details.css("div")[3].text

	gen = gen.gsub( /\s\s+/ , '' )
	actori = actori.gsub( /\s\s+/ , '' )
	regizor = regizor.gsub( /\s\s+/ , '' )

	cinematografe = film.css(".theatre-link")#.css("div")

	cinematografe.each do |cinematograf|
		cinemaName = cinematograf.text
		length = cinematograf.parent.css("div").length
		length1 = cinematograf.parent.parent.css("div").length
		case length
			when 0
				program = cinematograf.parent.parent.css("div")[1].text
			when 1
				program = cinematograf.parent.css("div")[0].text
		end

		program = program.gsub(/[^0-9:]/, '')
		length = (program.length)/5

		for i in 0..length do
			ora = program[i*5 , 5 ]
			j = j + 1
			intrare = {}
			intrare [ "id" ] = j
			intrare [ "image"] = img
			intrare [ "titluEn" ] = titluEn
			intrare [ "titluRo" ] = titluRo
			intrare [ "cinema" ] = cinemaName
			intrare [ "ora" ] = ora ;
			intrare [ "nota" ] = nota ;
			intrare [ "gen" ] = gen ;
			intrare [ "actori" ] = actori ;
			intrare [ "regizor" ] = regizor ;
			json.push ( intrare )
		end
	end
end


completeJSON = {}
completeJSON["movies"] = json
completeJSON["updated"] = Time.now.to_s

generatedJSON = JSON.generate( completeJSON )

File.open( 'date.json', 'w' ) { |file| file.write( generatedJSON ) }