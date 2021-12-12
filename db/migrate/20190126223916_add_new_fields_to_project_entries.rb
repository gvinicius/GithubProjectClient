# frozen_string_literal: true

class AddNewFieldsToProjectEntries < ActiveRecord::Migration[4.2]
  def change
    add_column :project_entries, :score, :string
    add_column :project_entries, :url, :text
  end
end
