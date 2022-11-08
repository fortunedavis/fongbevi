class Clip < ApplicationRecord
  has_one_attached :audio
  has_one :vote
end
