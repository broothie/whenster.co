class CreateInvites < ActiveRecord::Migration[7.0]
  def change
    create_table :invites, id: :uuid do |t|
      t.references :user, type: :uuid, null: false
      t.references :event, type: :uuid, null: false
      t.uuid :inviter_id, null: false

      t.string :role, null: false, default: "guest"
      t.string :status, null: false, default: "pending"

      t.timestamps
    end
  end
end
