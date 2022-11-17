class AddStatusToSentences < ActiveRecord::Migration[7.0]
  def change
    add_column :sentences, :status, :boolean, default: false
  end
end
