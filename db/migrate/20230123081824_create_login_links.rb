class CreateLoginLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :login_links, id: :uuid do |t|
      t.references :user, type: :uuid, null: false
      t.string :token, null: false

      t.timestamps
    end

    add_index :login_links, :token, unique: true
  end
end
