class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :status
      t.text :description
      t.references :project
      t.references :assigned_to

      t.timestamps
    end
    add_index :stories, :project_id
    add_index :stories, :assigned_to_id
  end
end