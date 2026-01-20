def foo(n, &b)
 puts n
 puts yield
end

block = -> (x) { x + 1 }
foo(3) { 2 }
