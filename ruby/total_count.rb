require 'net/http'
require 'uri'
require 'json'

ENDPOINT = URI.parse('https://api.github.com/graphql')

Net::HTTP.start ENDPOINT.host, ENDPOINT.port, use_ssl: ENDPOINT.scheme == 'https' do |http|
  query = <<~GRAPHQL
    query($name: String!, $owner: String!) {
      repository(name: $name owner: $owner) {
        openIssues: issues(states: OPEN) {
          totalCount
        }

        openPRs: pullRequests(states: OPEN) {
          totalCount
        }
      }
    }
  GRAPHQL

  request = Net::HTTP::Post.new(ENDPOINT.request_uri, 'Authorization': "Bearer #{ENV['PAT']}")

  request.body = JSON.generate(
    query:,

    variables: {
      owner: 'rails',
      name:  'rails',
    }
  )

  res = http.request(request)

  payload = JSON.parse(res.body, symbolize_names: true)

  pp payload
end
