res=$(curl -H "Authorization: bearer $PAT" -X POST -d "{\"query\":\"query(\$name: String!, \$owner: String!){repository(name:\$name owner:\$owner){openIssues: issues(states: OPEN){totalCount} openPRs: pullRequests(states: OPEN){totalCount}}}\", \"variables\":{\"name\": \"rails\", \"owner\": \"rails\"}}" https://api.github.com/graphql)

echo $res
