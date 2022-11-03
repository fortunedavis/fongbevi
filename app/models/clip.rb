class Clip < ApplicationRecord
  has_one_attached :audio
  belongs_to :clip
end
