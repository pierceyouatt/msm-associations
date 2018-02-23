class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.integer :movie_id
      t.integer :actor_id
      t.string :name_string

      t.timestamps
    end
  end
end
