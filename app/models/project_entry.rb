# frozen_string_literal: true

class ProjectEntry < ActiveRecord::Base
  validates :name, :url, :language, presence: true

  # The name 'upsert' comes from the sql jargon, meaning 'insert' or 'update'
  # This method stores a project entry from Github if it does not exist in database
  # or updates it without saving duplicates.
  def self.upsert_from_github(element)
    info_field = { info: element.except('name', 'language', 'url', 'score').to_json }
    data = element.slice('name', 'language', 'url', 'score').merge(info_field)
    result = ProjectEntry.where(name: element['name'])&.first
    if result.nil?
      result = ProjectEntry.create(data)
      result.save
    else
      result.update(data)
    end
    result
  end
end
