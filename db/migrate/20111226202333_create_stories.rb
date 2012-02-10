class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :status
      t.string :scope, :default => Scope::BACKLOG
      t.text :description
      t.references :project
      t.references :assigned_to
      t.float :hours_estimated
      t.float :hours_spent
      t.date :deadline
      t.integer :priority

      t.timestamps
    end
    add_index :stories, :project_id
    add_index :stories, :assigned_to_id
  end
end