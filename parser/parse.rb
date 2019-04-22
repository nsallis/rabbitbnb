require "bunny"
require 'uri'
require "net/http"
require "json"

$stdout.sync = true # make sure we print out from docker
sleep 10 # very crude, but we need do wait for rabbitmq to start
puts "starting message parser"
conn = Bunny.new host: "rabbitmq", user: "guest", pass: "guest"
conn.start

ch = conn.create_channel
x = ch.default_exchange
# # x = Bunny::Exchange.new(ch, :fanout, "activity.events")
q = ch.queue("ratings", exclusive: false, durable: false, auto_delete: false)

q.subscribe(manual_ack: true, consumer_tag: "foo") do |delivery_info, properties, payload|
  puts "received #{payload}, message properties are #{properties.inspect}"
  uri = URI.parse("http://api:3000/ratings")

  header = {'Content-Type': 'application/json'}

  # Create the HTTP objects
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.request_uri, header)
  request.body = properties[:headers].to_json

  # Send the request
  res = http.request(request)
  puts "got response from api: #{res.body.to_json}"
end
#
while true
  sleep 5
end
puts "closing app"
conn.close()
#
# # need to keep connection open here

