class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :status
      t.text :description
      t.references :project
      t.integer :assigned_to_id

      t.timestamps
    end
    add_index :stories, :project_id
  end
end
