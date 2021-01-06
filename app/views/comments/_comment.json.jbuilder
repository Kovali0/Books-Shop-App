json.extract! comment, :id, :username, :content, :product_id, :created_at, :updated_at
json.url comment_url(comment, format: :json)
