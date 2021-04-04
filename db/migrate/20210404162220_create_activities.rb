class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.string :title
      t.text :description
      t.string :category
      t.integer :heart_count
      t.integer :user_id
      t.timestamps
    end
  end
end
