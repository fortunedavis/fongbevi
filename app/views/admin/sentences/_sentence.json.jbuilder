json.extract! sentence, :id, :content, :is_used, :clips_count, :has_valid_clips, :created_at, :updated_at
json.url admin_sentence_url(sentence, format: :json)
