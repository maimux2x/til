b1 = Ruby::Box.new
b1.eval <<'RUBY'
  class User < Data.define(:name)
    def greeting = "Hello #{self.name}"
  end
RUBY

b2 = Ruby::Box.new
b2.eval <<'RUBY'
  class User < Data.define(:name)
    def greeting = "こんにちは #{self.name}"
  end

  class Test
    def self.test(a) = a.greeting
  end
RUBY

p b1::User.new('maimu') 
p b2::User.new('maimu')

p b1::User.new('maimu') == b2::User.new('maimu')

p b1::User.new('maimu').greeting
p b2::User.new('maimu').greeting

p b2::Test.test(b1::User.new('maimu'))
p b2::Test.test(b2::User.new('maimu'))
