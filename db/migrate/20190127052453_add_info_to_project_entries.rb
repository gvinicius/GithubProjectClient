# frozen_string_literal: true

class AddInfoToProjectEntries < ActiveRecord::Migration[4.2]
  def change
    add_column :project_entries, :info, :json
  end
end
