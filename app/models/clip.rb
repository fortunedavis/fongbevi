class Clip < ApplicationRecord

  has_one_attached :audio
  belongs_to :sentence
  belongs_to :user
  
  #validates_acceptance_of :audio, :content_type => [ 'audio/webm', 'audio/wav', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ]
 
  validates :sentence, :audio, :user, presence: true

  has_many :clip_sentences
  has_many :sentences, through: :clip_sentences
  
 
 
end   
