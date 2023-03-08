class Sentence < ApplicationRecord
  has_many :user_sentences
  has_many :users, through: :user_sentences
  #enum status: { nonvalid: 0, validated: 1, needupdate: 2 }

end
