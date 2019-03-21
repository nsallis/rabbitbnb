# sends a bunch of votes for the bnb we like

require "bunny"
require 'json'
require 'faker'

name = ARGV[0]


puts "Please specify a bnb to rate" unless name
return unless name

conn = Bunny.new host: "rabbitmq", user: "guest", pass: "guest"
conn.start

ch = conn.create_channel

x = ch.default_exchange # publishes to all queues

10.times do
  f_name = Faker::Name.unique.first_name
  l_name = Faker::Name.unique.last_name
  rating = {"name": name, "vote":1,"voter":{"first_name":f_name,"last_name":l_name}}
  x.publish("activity.events", {routing_key: "ratings", headers: rating})
end
conn.close()
