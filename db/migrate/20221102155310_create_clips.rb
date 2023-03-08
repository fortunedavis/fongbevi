class CreateClips < ActiveRecord::Migration[7.0]
  def change
    create_table :clips do |t|
      t.boolean :is_valid, default: false
      t.boolean :need_vote, default: true
      t.references :user
      t.references :sentence
      
      t.timestamps
    end
  end
end
