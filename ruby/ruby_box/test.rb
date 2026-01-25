b = Ruby::Box.new

b.eval <<'RUBY'
  class Foo
    def foo = 42
  end
RUBY

b.eval <<'RUBY'
  p Foo.new.foo
RUBY

begin
  Foo.new
rescue => e
  p e.class, e.message
  p b::Foo.new.foo
end
