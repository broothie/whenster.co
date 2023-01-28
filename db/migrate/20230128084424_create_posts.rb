class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts, id: :uuid do |t|
      t.references :invite, type: :uuid, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
