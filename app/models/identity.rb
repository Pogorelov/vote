class Identity < ActiveRecord::Base
  belongs_to :user, foreign_key: 'voter_id'

  validates_uniqueness_of :uid, scope: :provider
end
