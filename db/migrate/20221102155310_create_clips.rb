class CreateClips < ActiveRecord::Migration[7.0]
  def change
    create_table :clips do |t|
      t.boolean :is_valid
      t.boolean :need_votes
      t.references :user
      t.references :sentence
      
      t.timestamps
    end
  end
end
