class Vote < ApplicationRecord
  belongs_to :clip
  belongs_to :user
end
