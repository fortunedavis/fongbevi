class Clip < ApplicationRecord

  has_one_attached :audio
  belongs_to :sentence
  belongs_to :user
  has_one_attached :file
  #validates_attachment_content_type :file, :content_type => [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ]
  #validates_acceptance_of :file, :content_type => [ 'audio/mpeg', 'audio/wav', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ]
 
  validates :sentence, :audio, :user, presence: true

  has_many :clip_sentences
  has_many :sentences, through: :clip_sentences
  
  
 
end   
