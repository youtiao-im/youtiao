object feed

attributes :id,
           :channel_id,
           :text,
           :created_at,
           :updated_at,
           :creator_id,
           :checked_by_ids,
           :crossed_by_ids,
           :questioned_by_ids

attributes checked?: :is_checked,
           crossed?: :is_crossed,
           questioned?: :is_questioned

child :attachments do
  attributes :text, :url
end
