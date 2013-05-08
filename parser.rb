# encoding: UTF-8
require 'nokogiri'
require 'open-uri'
require 'json'

#page = Nokogiri::HTML(open('http://www.cinemagia.ro/program-cinema/bucuresti/'))
page = Nokogiri::HTML(open('shit.html'))

json = []
movies = page.css(".program_cinema_show")
puts movies[0].css(".title_ro").text
j = 0
for k in 0..(movies.length-1) do
	film = movies[k]
	titluRo = film.css(".title_ro").text
	titluEn = film.css("h2:first").text
	puts titluEn
	details = film.css(".info")[0]

	nota = details.css("div")[0].text
	gen = details.css("div")[1].text
	actori = details.css("div")[2].text
	#regizor = details.css("div")[3].text

	gen = gen.gsub( /\s\s+/ , '' )
	actori = actori.gsub( /\s\s+/ , '' )
	#regizor = regizor.gsub( /\s\s+/ , '' )

	cinematografe = film.css(".program").css("div")

	cinematografe.each do |cinematograf|
		cinemaName = cinematograf.css(".theatre-link")[0].text

		#puts "program length" + cinematograf.css("div").length.to_s
		length = cinematograf.css("div").length
		puts k.to_s + " " + cinemaName + " " + length.to_s
		case length
			when 0
				next
			when 1
				program = cinematograf.css("div")[0].text
			when 2
				program = cinematograf.css("div")[1].text
		end
		# if cinematograf.css("div").length == 0
		# 	next
		# 	# program = cinematograf.parent.css("div")[0].text
		# 	#
		# 	# puts "prg1 " #+ program.length.to_s
		# else
		# 	program = cinematograf.css("div")[1].text
		# 	puts k.to_s + " " + cinemaName
		# 	puts "prg2 " + program.length.to_s
		# end



		#puts program
		program = program.gsub(/[^0-9:]/, '')
		length = (program.length)/5
		#puts program
		for i in 0..length do
			ora = program[i*5 , 5 ]
			puts ora
			j = j + 1
			intrare = {}
			intrare [ "id" ] = j
			intrare [ "titluEn" ] = titluEn
			intrare [ "titluRo" ] = titluRo
			intrare [ "cinema" ] = cinemaName
			intrare [ "ora" ] = ora ;
			intrare [ "nota" ] = nota ;
			intrare [ "gen" ] = gen ;
			intrare [ "actori" ] = actori ;
			#intrare [ "regizor" ] = regizor ;
			json.push ( intrare )
		end
	end
	exit()
end


completeJSON = {}
completeJSON["movies"] = json
completeJSON["updated"] = Time.now.to_s

generatedJSON = JSON.generate( completeJSON )

File.open( 'date.json', 'w' ) { |file| file.write( generatedJSON ) }