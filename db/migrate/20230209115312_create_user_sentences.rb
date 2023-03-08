class CreateUserSentences < ActiveRecord::Migration[7.0]
  def change
    create_table :user_sentences do |t|
      t.belongs_to :user, index: true
      t.belongs_to :sentence, index: true
    end
  end
end
