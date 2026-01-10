data = [
  { user_id: 1, name: "Alice" },
  { user_id: 1, name: "Bob" },
  { user_id: 2, name: "Carol" }
]

result = Hash.new {|h, k| h[k] = [] }

p data.inject(result) {|h, obj|
  key = obj[:user_id]
  h.merge(key => h[key] + [obj])
}

p result
