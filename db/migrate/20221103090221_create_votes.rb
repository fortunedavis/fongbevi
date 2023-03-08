class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.boolean :is_valid
      t.belongs_to :user
      t.belongs_to :clip
      
      t.timestamps
    end
  end
end
