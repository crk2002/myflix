class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :user_id
      t.string :recipient_email
      t.string :recipient_name
      t.string :message
      t.integer :recipient_id
      t.string :token
    end
  end
end
