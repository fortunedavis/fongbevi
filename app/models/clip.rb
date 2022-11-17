class Clip < ApplicationRecord
  has_one_attached :audio
  belongs_to :sentence
  belongs_to :user

  validates :sentence, :audio, :user,presence: true
end
