json.extract! project_entry, :id, :name, :link, :language, :created_at, :updated_at
json.url project_entry_url(project_entry, format: :json)
