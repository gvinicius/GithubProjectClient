class CreateProjectEntries < ActiveRecord::Migration
  def change
    create_table :project_entries do |t|
      t.string :name
      t.string :link
      t.string :language

      t.timestamps null: false
    end
  end
end
