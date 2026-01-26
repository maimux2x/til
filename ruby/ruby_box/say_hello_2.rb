require "./greeting"

# Greeting.new.say_hello

# Greeting.polite = true
# Greeting.new.say_hello

# t = Thread.new { Greeting.new.say_hello }
# Greeting.polite = false
# t.join

b1 = Ruby::Box.new
b1.require "./greeting"

b2 = Ruby::Box.new
b2.require "./greeting"

b2::Greeting.polite = true

[
  Thread.new { b1::Greeting.new.say_hello },
  Thread.new { b2::Greeting.new.say_hello }
].each(&:join)
