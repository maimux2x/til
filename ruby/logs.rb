logs = [
  { user_id: 1, status: "success" },
  { user_id: 1, status: "failure" },
  { user_id: 2, status: "success" },
  { user_id: 2, status: "success" },
  { user_id: 1, status: "pending" }
]

logs.each_with_object(Hash.new {|h, k| h[k] = {success: 0, failure: 0}}) {|object, h|
  key    = object[:user_id]
  status = object[:status].to_sym

  h[key][status] ||= 0
  h[key][status] += 1
}
