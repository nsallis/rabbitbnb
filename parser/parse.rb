require "bunny"
$stdout.sync = true
sleep 10 # very crude, but we need do wait for rabbitmq to start
puts "starting message parser"
conn = Bunny.new host: "rabbitmq", user: "guest", pass: "guest"
conn.start

ch = conn.create_channel
x = ch.default_exchange
puts "created exchange"
# # x = Bunny::Exchange.new(ch, :fanout, "activity.events")
q = ch.queue("ratings", exclusive: false, durable: true, auto_delete: false)
puts "created queue"
# # x.publish("activity.events",
# #           :routing_key => "#{q.name}",
# #           :app_id      => "bunny.example",
# #           :priority    => 8,
# #           :type        => "kinda.checkin",
# #           # headers table keys can be anything
# #           :headers     => {
# #             :coordinates => {
# #               :latitude  => 59.35,
# #               :longitude => 18.066667
# #             },
# #             :time         => Time.now,
# #             :participants => 11,
# #             :venue        => "Stockholm",
# #             :true_field   => true,
# #             :false_field  => false,
# #             :nil_field    => nil,
# #             :ary_field    => ["one", 2.0, 3, [{"abc" => 123}]]
# #           },
# #           :timestamp      => Time.now.to_i,
# #           :reply_to       => "a.sender",
# #           :correlation_id => "r-1",
# #           :message_id     => "m-1")
#
# puts('subscribing to message queue')
# puts "pulling from queue"
q.subscribe(manual_ack: true, consumer_tag: "foo") do |delivery_info, properties, payload|
  puts "received #{payload}, message properties are #{properties.inspect}"
end
puts "subscribed"
#
while true
  puts "sleeping"
  sleep 5
end
puts "closing app"
conn.close()
#
# # need to keep connection open here

