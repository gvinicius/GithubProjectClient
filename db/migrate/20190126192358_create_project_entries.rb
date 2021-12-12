# frozen_string_literal: true

class CreateProjectEntries < ActiveRecord::Migration[4.2]
  def change
    create_table :project_entries do |t|
      t.string :name
      t.string :link
      t.string :language

      t.timestamps null: false
    end
  end
end
