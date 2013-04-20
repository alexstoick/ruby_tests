import grequests

urls = [
	"http://maps.googleapis.com/maps/api/distancematrix/json?origins=44.419560%2C26.1266510&destinations=44.428742%2C26.15415&sensor=false"
]

rs = (grequests.get(u) for u in urls)
print ( grequests.map(rs) )
print ( '133' )