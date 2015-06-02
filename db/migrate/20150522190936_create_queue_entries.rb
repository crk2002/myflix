class CreateQueueEntries < ActiveRecord::Migration
  def change
    create_table :queue_entries do |t|
      t.integer :video_id
      t.integer :user_id
      t.integer :position
      t.timestamps
      t.index [:user_id, :video_id]
    end
  end
end
