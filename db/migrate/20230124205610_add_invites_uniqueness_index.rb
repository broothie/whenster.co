class AddInvitesUniquenessIndex < ActiveRecord::Migration[7.0]
  def change
    add_index :invites, [:user_id, :event_id], unique: true
  end
end
