# def group_by_key(array, key)
#   result = {}

#   array.each do |obj|
#     result[obj[key]] = []
#   end

#   array.each do |obj|
#     result.each do |k, v|
#       v.push obj if obj[key] == k
#     end
#   end

#   result
# end

def group_by_key(array, key)
  result = {}

  array.each do |obj|
    k = obj[key]
    result[k] ||= []
    result[k] << obj
  end

  result
end


data = [
  { user_id: 1, name: 'Alice' },
  { user_id: 1, name: 'Bob' },
  { user_id: 2, name: 'Carol' }
]

p group_by_key(data, :user_id)

data = [
  { 'team' => 'backend', 'user' => 'Alice' },
  { 'team' => 'frontend', 'user' => 'Bob' },
  { 'team' => 'backend', 'user' => 'Carol' }
]

p group_by_key(data, 'team')
