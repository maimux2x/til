require 'net/http'
require 'uri'
require 'json'

ENDPOINT = URI.parse('https://api.github.com/graphql')

Net::HTTP.start ENDPOINT.host, ENDPOINT.port, use_ssl: ENDPOINT.scheme == 'https' do |http|
  query = <<~GRAPHQL
    query FindIssueID($name: String!, $owner: String!, $number: Int!){
      repository(name: $name, owner: $owner){
        issue(number: $number){
          id
        }
      }
    }
  GRAPHQL

  request = Net::HTTP::Post.new(ENDPOINT.request_uri, 'Authorization': "Bearer #{ENV['PAT']}")

  request.body = JSON.generate(
    query:,

    variables: {
      name:   'bookshelf',
      owner:  'maimux2x',
      number: 11,
    }
  )

  res     = http.request(request)
  payload = JSON.parse(res.body, symbolize_names: true)

  mutation = <<~GRAPHQL
    mutation AddReactionToIssue($reactionInput:AddReactionInput!) {
      addReaction(input:$reactionInput){
        reaction{
          content
        }

        subject{
          id
        }
      }
    }
  GRAPHQL

  request = Net::HTTP::Post.new(ENDPOINT.request_uri, 'Authorization': "Bearer #{ENV['PAT']}")

  request.body = JSON.generate(
    query: mutation,

    variables: {
      reactionInput: {
        subjectId: payload.dig(:data, :repository, :issue, :id),
        content:   'HOORAY'
      }
    }
  )

  res = http.request(request)
  p res.body
end
