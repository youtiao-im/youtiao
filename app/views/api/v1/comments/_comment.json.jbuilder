json.partial! 'api/v1/models/comment', comment: comment

json.created_by do
  json.partial! 'api/v1/models/user', user: comment.created_by
end
