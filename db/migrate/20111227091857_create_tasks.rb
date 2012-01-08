class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :status
      t.references :story
      t.integer :assigned_to_id
      t.float :hours_estimated
      t.float :hours_spent
      t.date :deadline

      t.timestamps
    end
    add_index :tasks, :story_id
  end
end