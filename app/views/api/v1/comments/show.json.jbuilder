json.partial! 'api/v1/shared/comment', comment: comment

json.created_by do
  json.partial! 'api/v1/shared/membership', membership: comment.created_by
end
