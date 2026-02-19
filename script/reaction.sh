res=$(curl -H "Authorization: bearer $PAT" -X POST -d '{"query":"query FindIssueID($name:String!, $owner:String!, $number:Int!){repository(name:$name, owner:$owner){issue(number:$number){id}}}", "variables":{"name":"bookshelf", "owner":"maimux2x","number": 11}}' https://api.github.com/graphql)

subject_id=$(echo $res | jq .data.repository.issue.id)

res2=$(curl -H "Authorization: bearer $PAT" -X POST -d "{\"query\":\"mutation AddReactionToIssue(\$reactionInput:AddReactionInput!) {addReaction(input:\$reactionInput){reaction{content} subject{id}}}\", \"variables\":{\"reactionInput\":{\"subjectId\":$subject_id,\"content\":\"HOORAY\"}}}" https://api.github.com/graphql)

echo $res2 | jq
