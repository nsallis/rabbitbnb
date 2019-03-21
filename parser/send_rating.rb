# sends a rating to the "rating" channel

require "bunny"
require 'json'

name = ARGV[0]
f_name = ARGV[1]
l_name = ARGV[2]
puts "Please specify a bnb to rate" unless name
puts "Please specify a first name" unless f_name
puts "Please specify a last name" unless l_name
return unless name
return unless f_name
return unless l_name

conn = Bunny.new host: "rabbitmq", user: "guest", pass: "guest"
conn.start

ch = conn.create_channel

x = ch.default_exchange # publishes to all queues
rating = {"name": name, "vote":1,"voter":{"first_name":f_name,"last_name":l_name}}
x.publish("activity.events", {routing_key: "ratings", headers: rating})
conn.close()
