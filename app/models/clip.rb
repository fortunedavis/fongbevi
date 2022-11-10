class Clip < ApplicationRecord
  has_one_attached :audio
  has_one :vote
  belongs_to :sentence
  validates :sentence, :audio, presence: true
end
