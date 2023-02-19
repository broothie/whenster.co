class CreateEmailInvites < ActiveRecord::Migration[7.0]
  def change
    create_table :email_invites, id: :uuid do |t|
      t.references :event, type: :uuid, null: false
      t.string :email, null: false
      t.string :role
      t.uuid :inviter_id, null: false

      t.timestamps
    end

    add_index :email_invites, :email
    add_index :email_invites, :inviter_id
    add_index :email_invites, [:event_id, :email], unique: true
  end
end
