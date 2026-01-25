b1 = Ruby::Box.new
b1.require './greeting-1.0.0'

b2 = Ruby::Box.new
b2.require './greeting-2.0.0'

p b1::Greeting::VERSION
p b2::Greeting::VERSION

p b1::Greeting.new.say_hello
p b2::Greeting.new.say_hello('maimu')
