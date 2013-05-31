require 'net/http'

start = Time.now

cond = ARGV[0]

if ( cond == "1")
	link = "http://cinemadistance.eu01.aws.af.cm/movies/"
	link = "http://localhost:3000/movies"
	th = []
	urls=[]
	for i in 1..45 do
		urls[i-1] = link + i.to_s + "/aparitii"
	end
	i=0
	completed = 0
	total = 45*10
	for j in 0..10 do
		urls.each do |url|
			th[i] =Thread.new do
				start = Time.now
				content = Net::HTTP.get( URI.parse( url ) )
				fin = Time.now
				completed += 1
				puts "For " + url.to_s + " duration: " + (fin-start).to_s + " " + completed.to_s + " / " + total.to_s
			end
			i += 1
		end
	end
	th.each { |t| t.join }
	exit()
end

if ( cond == "2" )

	link = "http://cinemadistance.eu01.aws.af.cm/parser/"
	th = []
	i=0

	for j in 0..20 do
		th[i] =Thread.new do
			start = Time.now
			content = Net::HTTP.get( URI.parse( link ) )
			fin = Time.now
			puts "For " + link.to_s + " duration: " + (fin-start).to_s
		end
		i += 1
	end

	th.each { |t| t.join }

	exit()
end
