# frozen_string_literal: true

class ProjectEntry < ActiveRecord::Base
  # The name 'upsert' comes from the sql jargon, meaning 'insert' or 'update'
  def self.upsert_from_github(element)
    info_field = { info: element.except('name', 'language', 'url', 'score').to_json }
    result = ProjectEntry.where(name: element['name'])&.first
    data = element.slice('name', 'language', 'url', 'score').merge(info_field)
    if result.nil?
      result = ProjectEntry.create(data)
      result.save
    else
      result.update(data)
    end
    result
  end
end
