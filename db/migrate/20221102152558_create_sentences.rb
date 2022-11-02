class CreateSentences < ActiveRecord::Migration[7.0]
  def change
    create_table :sentences do |t|
      t.string :content
      t.boolean :is_used
      t.integer :clips_count
      t.boolean :has_valid_clips
      t.references :user
      t.timestamps
    end
  end
end
