class AddIndexToInviterId < ActiveRecord::Migration[7.0]
  def change
    add_index :invites, :inviter_id
  end
end
