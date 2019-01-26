class AddNewFieldsToProjectEntries < ActiveRecord::Migration
  def change
    add_column :project_entries, :score, :string
    add_column :project_entries, :url, :text
  end
end
