require 'mongo'

include Mongo

client = MongoClient.new('localhost', 27017)

puts client.database_names

client.database_info.each { |info| puts info.inspect }

db     = client['stiri']
coll   = db['hotnews']

obj = { "url" => "http://hotnews.ro/rss" , "lastUpdated" => "0801" , "articleCount" => 170 }

id = coll.insert( obj )

puts id

# @coll.remove

# 3.times do |i|
#   @coll.insert({'a' => i+1})
# end

# puts "There are #{@coll.count} records. Here they are:"
# @coll.find.each { |doc| puts doc.inspect }