require 'net/http'
require 'uri'
require 'json'

ENDPOINT = URI.parse('https://api.github.com/graphql')

Net::HTTP.start ENDPOINT.host, ENDPOINT.port, use_ssl: ENDPOINT.scheme == 'https' do |http|
  query = <<~GRAPHQL
    query($name: String!, $owner: String!, $cursor: String) {
      repository(name: $name owner: $owner) {
        nameWithOwner
        stargazerCount
        forkCount

        defaultBranchRef {
          name
        }

        issues(first: 10, after: $cursor, states: OPEN, orderBy: {field: CREATED_AT, direction: DESC}) {
          nodes {
            number
            title
            url
            createdAt
          }

          pageInfo {
            endCursor
            hasNextPage
          }
        }
      }
    }
  GRAPHQL

  cursor = nil

  loop do
    request = Net::HTTP::Post.new(ENDPOINT.request_uri, 'Authorization': "Bearer #{ENV['PAT']}")

    request.body = JSON.generate(
      query:,

      variables: {
        owner:  'rails',
        name:   'rails',
        cursor:
      }
    )

    res = http.request(request)

    payload = JSON.parse(res.body, symbolize_names: true)

    payload.dig(:data, :repository, :issues, :nodes).each do |issue|
      puts "##{issue[:number]} #{issue[:title]}"
      puts "#{Time.new(issue[:createdAt]).localtime.strftime('%F %T')} #{issue[:url]}"
      puts '-' * 100
    end

    break unless payload.dig(:data, :repository, :issues, :pageInfo, :hasNextPage)

    cursor = payload.dig(:data, :repository, :issues, :pageInfo, :endCursor)
  end
end
