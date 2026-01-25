b1 = Ruby::Box.new
b1.eval <<'RUBY'
  class Integer
    def /(other) = self.quo(other.n)
  end
  ONE = 1
  TWO = 2
RUBY

# b2 は引数に対して / を呼ぶ
b2 = Ruby::Box.new
b2.eval <<'RUBY'
  class Test
    def self.test(a, b) = a / b
  end
RUBY

p b2::Test.test(b1::ONE, b1::TWO)
