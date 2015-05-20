json.call feed, :id, :text, :checks_count, :crosses_count, :questions_count,
          :comments_count, :created_at, :updated_at
json.created_by do
  json.partial! 'api/v1/users/user', user: feed.created_by
end
