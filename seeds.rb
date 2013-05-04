#<Encoding:UTF-8>
require 'net/http'
require 'json'

link = 'http://thawing-fortress-7476.herokuapp.com/date.json'


# file = open ( "date.txt")
# content = file.read

content = Net::HTTP.get( URI.parse(link) )
parsed = JSON.parse(content)

# json = {"movies":[{"titluEn":"Admission (2013)","titluRo":"Admis pe pile","cinema":"Movieplex Cinema Plaza","ora":"12:00","nota":"Not\u0103 7.2 \/ Imdb 5.3","gen":"Gen film: Comedie, Dram\u0103, Romantic ","actori":"Cu: Paul Rudd, Tina Fey ","regizor":"Regizor: Paul Weitz "}]}
# movies = JSON.parse ( json )

movies = parsed["movies"]
#movie = [{"titluEn":"Admission (2013)","titluRo":"Admis pe pile","cinema":"Movieplex Cinema Plaza","ora":"12:00","nota":"Not\u0103 7.2 \/ Imdb 5.3","gen":"Gen film: Comedie, Dram\u0103, Romantic ","actori":"Cu: Paul Rudd, Tina Fey ","regizor":"Regizor: Paul Weitz "}]


movies.each do |movie|
#	Movie.create ( movie )
	titluEn = movie["titluEn"]
	titluRo = movie["titluRo"]
	nota = movie["nota"]
	regizor = movie["regizor"]
	actori = movie["actori"]
	gen = movie["gen"]
	puts nota
#	Movie.create( titluEn:titluEn , titluRo:titluRo , nota:nota.inspect , regizor:regizor , actori:actori, gen:gen )
	exit()
end
