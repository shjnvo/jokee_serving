class CreateJokes < ActiveRecord::Migration[7.1]
  def change
    create_table :jokes do |t|
      t.text :content
      t.integer :likes_count, default: 0
      t.integer :dislikes_count, default: 0

      t.timestamps
    end
  end
end
