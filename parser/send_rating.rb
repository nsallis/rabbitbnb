# sends a rating to the "rating" channel

require "bunny"
require 'json'

name = ARGV[0]
puts "Please specify a bnb to rate" unless name
return unless name

conn = Bunny.new host: "rabbitmq", user: "guest", pass: "guest"
conn.start

ch = conn.create_channel

x = ch.default_exchange # publishes to all queues
rating = {"name": name, "vote":1,"voter":{"first_name":"Jack","last_name":"Collier"}}
x.publish("activity.events", {routing_key: "ratings", headers: rating})
conn.close()
