json.extract! poll, :id, :title, :created_at, :updated_at, :timeframe_start, :timeframe_end
json.url poll_url(poll, format: :json)
