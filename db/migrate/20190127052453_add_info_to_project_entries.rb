class AddInfoToProjectEntries < ActiveRecord::Migration
  def change
    add_column :project_entries, :info, :json
  end
end
