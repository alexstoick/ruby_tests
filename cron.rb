require 'net/http'


loop {
    url = URI.parse('http://parsercinema.eu01.aws.af.cm/index.php') #'http://localhost/pq/index.php')
	req = Net::HTTP::Get.new(url.path)
	res = Net::HTTP.start(url.host, url.port) {|http|
	  http.request(req)
	}
	puts res.body + '                                at time:' + Time.now.inspect
	sleep 60*60
}

