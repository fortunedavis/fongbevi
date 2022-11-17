class Clip < ApplicationRecord
  has_one_attached :audio
  belongs_to :sentence
  validates :sentence, :audio, presence: true
end
