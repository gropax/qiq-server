json.array!(@notes) do |note|
  json.(note, :id, :content, :created_at, :updated_at)
end
