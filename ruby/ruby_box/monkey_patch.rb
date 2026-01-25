b = Ruby::Box.new

b.eval <<'RUBY'
  class Integer
    def /(other) = self.quo(other)
  end
RUBY

b.eval <<'RUBY'
  p 5 / 3
RUBY

p 5 / 3
