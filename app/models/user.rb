class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable,
         :registerable,:jwt_authenticatable,
          omniauth_providers: %i[google_oauth2],jwt_revocation_strategy: JwtDenylist


  enum  role: [:user,:admin,:superadmin]  
 
  after_initialize :set_default_role, :if=>:new_record?
 
  has_many :sentences
  has_many :clips

  def set_default_role
    self.role ||= :user
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.fullname = auth.info.name # assuming the user model has a name
            #user.avatar_url = auth.info.image # assuming the user model has an image
            # If you are using confirmable and the provider(s) you use validate emails,
            # uncomment the line below to skip the confirmation emails.
            # user.skip_confirmation!
    end
  end
  
end
