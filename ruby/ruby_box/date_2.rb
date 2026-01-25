b1 = Ruby::Box.new
b1.require "date"

b2 = Ruby::Box.new
b2.require "date"

t1 = b1::Time.new(2025, 12, 25)
t2 = b2::Time.new(2025, 12, 25)

p t1
p t2

p t1 == t2

d1 = b1::Date.new(2025, 12, 25)
d2 = b2::Date.new(2025, 12, 25)

p d1
p d2

p d1 == d2
