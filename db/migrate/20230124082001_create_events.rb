class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events, id: :uuid do |t|
      t.string :title, null: false
      t.text :description
      t.string :location
      t.string :place_id
      t.string :timezone
      t.timestamp :start_at, null: false
      t.timestamp :end_at, null: false

      t.timestamps
    end

    add_index :events, :start_at
    add_index :events, :end_at
  end
end
