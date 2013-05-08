require 'open-uri'
require 'nokogiri'
require 'timeout'

link = "http://www.emp3world.com/search/"
th = []
i=0
contor = 0
completed = 0
File.open('music.json').each do |line|
	th[i] = Thread.new do
		line = line.gsub( /\n/ , '')
		original_line = line
		line = line.gsub( " " , "_")

		current_link = link + line + "_mp3_download.html"
		line =  line.gsub(/[^\w\s_-]+/, '')
					.gsub(/(^|\b\s)\s+($|\s?\b)/, '\\1\\2')
					.gsub(/\s+/, '_')
		begin
			page = Nokogiri::HTML(open(current_link))
			rescue => exc
				puts "IMPORTANT ################################" + exc.message
				next
		end
		download_link = ""
		dw_links = page.css(".song_item") ;

		timer = Time.now
		tries = 0
		downloaded = false
		entered = false
		expired = 0
		dw_links.each do |dw_link|
			entered = true
			if dw_link.css(".song_size").text.to_f > 3.1

				download_link = dw_link.css("a")[1]["href"]
				begin
					download_link = URI.escape(download_link)
					download_link = download_link.gsub( " " , "_")
					download_link = URI.parse(download_link)
					rescue => exc
						#puts "BAD URI" + exc.message
				end
				tries = tries + 1
				done = true
				current_try_time = Time.now
				File.open("songs/" + line+".mp3", "wb") do |saved_file|
					begin
						Timeout::timeout(15){
							open(download_link, 'rb' ) do |read_file|
								saved_file.write(read_file.read)
							end
						}
						rescue => exc
							if ( exc.message == "execution expired" )
								expired += 1
							end
#							puts "ERROR <<TIMEOUT>>" + original_line + exc.message
							done = false
					end
				end
				if done
					completed = completed + 1
					downloaded = true
					printf( "Downloaded %-40s , total duration: %5.2f, tries: %3d, current time of download %5.2f %d/%d\n" , original_line , 
							(Time.now - timer) , tries , (Time.now - current_try_time) ,  completed, contor )
					# puts "Downloaded " + original_line + "		time:" + (Time.now - timer).to_s + "		after: " + tries.to_s + " tries" + 
					# 				" with a time of: " + (Time.now - current_try_time).to_s
					break
				end
			end
		end
		if !downloaded
			printf( "Failed to download %-40s ; after : %3d tries out of which were killed due to late response %3d ; found : %s; %d/%d\n" , original_line , tries , expired, entered , completed, contor )
		end
	end
	i=i+1
	contor += 1
end

th.each do |t|
	t.join
end

puts "Successfully downloaded " + completed.to_s + " out of " + contor.to_s