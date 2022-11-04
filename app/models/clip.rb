class Clip < ApplicationRecord
  has_one_attached :audio
  has_many :votes
end
