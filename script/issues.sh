next_cursor='""'
has_next_page=true

while [ $has_next_page ]; do
		res=$(curl -H "Authorization: bearer $PAT" -X POST -d "{\"query\":\"query(\$name: String!, \$owner: String!, \$cursor: String){repository(name:\$name owner:\$owner){nameWithOwner stargazerCount forkCount defaultBranchRef{name} issues(first:10, after: \$cursor, states: OPEN, orderBy: {field: CREATED_AT, direction: DESC}){nodes{number title url createdAt} pageInfo{endCursor hasNextPage}}}}\", \"variables\":{\"name\": \"rails\", \"owner\": \"rails\", \"cursor\": $next_cursor}}" https://api.github.com/graphql)
  
		echo $res | jq '.data.repository.issues.nodes'

		has_next_page=$(echo $res | jq '.data.repository.issues.pageInfo.hasNextPage')
		next_cursor=$(echo $res | jq '.data.repository.issues.pageInfo.endCursor')
done
