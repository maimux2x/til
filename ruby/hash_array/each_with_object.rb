data = [
  { user_id: 1, name: "Alice" },
  { user_id: 1, name: "Bob" },
  { user_id: 2, name: "Carol" }
]

result1 = data.each_with_object({}) {|obj, h|
  k = obj[:user_id]

  h[k] ||= []
  h[k] << obj
}

p result1

result2 = Hash.new([])

data.each_with_object(result2) {|obj, h|
  h[obj[:user_id]] << obj
}

p result2

result3 = Hash.new{|h, k| h[k] = []}

data.each_with_object(result3) {|obj, h|
  h[obj[:user_id]] << obj
}

p result3
