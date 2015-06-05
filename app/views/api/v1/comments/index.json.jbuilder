json.array! comments do |comment|
  json.partial! 'api/v1/shared/comment', comment: comment

  json.created_by do
    json.partial! 'api/v1/shared/user', user: comment.created_by
  end
end
