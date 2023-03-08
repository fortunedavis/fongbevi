class CreateSentences < ActiveRecord::Migration[7.0]
  def change
    create_table :sentences do |t|
      t.string :content
      t.boolean :has_clip, default: false
      t.boolean :has_valid_clips, default: false
      t.string :slug
      t.integer :status
      t.references :user
      t.timestamps
    end
    
  end
end
