class AddUsersToActivities < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :users, :text
  end
end
