class User < ActiveRecord::Base
  has_one :profile, :dependent => :destroy
  has_many :events, :dependent => :destroy
  after_create :create_profile_with_omniauth

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]


  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :fb_id => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        @user = User.create!(name:auth.extra.raw_info.name, 
                            provider:auth.provider,
                            fb_id:auth.uid,
                            email:auth.info.email,
                            fb_token:auth.credentials.token,
                            password:Devise.friendly_token[0,20]
                          )
          
      end
    end
  end

  def create_profile_with_omniauth
    fb_profile = FbGraph::User.new("me", :access_token => self.fb_token).fetch
    Profile.create!(first_name:fb_profile.first_name,
                    last_name:fb_profile.last_name,
                    gender:fb_profile.gender,
                    website:fb_profile.website,
                    locale:fb_profile.locale,
                    bio:fb_profile.bio,
                    user_id:self.id
                    )
  end

  def provider_connection?
    fb_token.blank? ? false : true 
  end

end
