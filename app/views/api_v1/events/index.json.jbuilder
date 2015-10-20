json.metadata do
  json.total Event.count
end

json.data @events do |e|
  json.id e.id
  json.name e.name
  json.created_at e.created_at
end
