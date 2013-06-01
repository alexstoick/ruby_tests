require 'nokogiri'
require 'open-uri'
require 'net/smtp'

link = 'http://www.weather.com/weather/hourbyhour/graph/ROXX0003'

old_condition = ""
old_temp_c = 0
old_precip = 0

loop {
	page = Nokogiri::HTML( open( link ) )

	info = page.css ( ".wx-first" )

	condition = "Condition - " + info.css(".wx-phrase").text

	temp = info.css(".wx-temp").text
	temp_c = ((temp.to_i-32)/1.8).round(2)

	details = info.css(".wx-details")

	feels_like = details.css("dl")[0].text.gsub( /\n/ , '' )
	humidity = details.css("dl")[1].text.gsub( /\n/ , '' )
	precip = details.css("dl")[2].text.gsub( /\n/ , '' ).to_i
	wind = details.css("dl")[3].text.gsub( /\n/ , '' )

	time = Time.now
	time.localtime ( "+03:00")
	time = time.to_s

	message = "Subject: Weather status at #{time} \n"

	# message += condition + "; \t" + temp_c.to_s + "\n" +
	# 		humidity + "\n" + "Precipitation:" + precip.to_s + "\n" + wind
	# # message = "Subject: Weather status "+ "\n"

	txt = 'abc '

	message +=  condition + "\n" + "TEMPERATURE: " + temp_c.to_s	+
				"\n" + "PRECIPATION: " + (precip.to_i).to_s + "%" + "\n" + wind + "\n" + time

	if ( condition != old_condition || precip != old_precip )
		old_condition = condition
		old_precip = precip
		old_temp_c = temp_c

		password = '####'
		smtp = Net::SMTP.new 'smtp.gmail.com', 587
		smtp.enable_starttls
		smtp.start('gmail.com', 'alex.stoicajr@gmail.com', password , :login)
		smtp.send_message message, 'FROM@gmail.com', 'alex.stoicajr@gmail.com'
		smtp.finish
		puts "Sent at " + time
	else
		puts 'same conditions'
	end

	sleep 60*60
}