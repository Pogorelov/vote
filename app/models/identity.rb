class Identity < ActiveRecord::Base
  belongs_to :user, foreign_key: 'voter_id'

  validates_uniqueness_of :uid, scope: :provider

  def self.find_for_google_oauth(auth)
    identity = Identity.find_by(provider: auth['provider'], uid: auth['uid'])
    if identity.nil?
      registered_user = User.find_by(email: auth['info']['email'])
      if registered_user.nil?
        user = User.create!(
          name: auth['info']['name'],
          email: auth['info']['email'],
          password: Devise.friendly_token[0,20],
        )
        identity = Identity.create!(
          provider: auth['provider'],
          uid: auth['uid'],
          user: user
        )
        user
      else
        Identity.create!(
          provider: auth['provider'],
          uid: auth['uid'],
          user: registered_user
        )
        registered_user
      end
    else
      identity.user
    end
  end
end
