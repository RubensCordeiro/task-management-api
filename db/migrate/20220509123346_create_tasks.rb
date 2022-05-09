class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.string :summary
      t.text :description
      t.datetime :due_date, null: false
      t.string :priority, default: 'medium'
      t.boolean :urgent, default: false
      t.boolean :finished, default: false
      t.timestamps
    end
  end
end
