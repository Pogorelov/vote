class Identity < ActiveRecord::Base
  belongs_to :user, foreign_key: 'voter_id'

  validates_uniqueness_of :uid, scope: :provider

  def self.find_for_omniauth(auth)
    user = User.find_or_create_by( email: auth['info']['email'] ) do |user|
      user.name = auth['info']['name']
      user.password = Devise.friendly_token[0,20]
    end
    Identity.find_or_create_by provider: auth['provider'], uid: auth['uid'], user: user
    user
  end
end
