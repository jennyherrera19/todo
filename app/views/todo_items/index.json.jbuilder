json.array!(@todo_items) do |todo_item|
  json.extract! todo_item, :id, :name, :todo_list_id
  json.url todo_item_url(todo_item, format: :json)
end
