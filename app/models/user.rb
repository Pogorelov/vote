class User < Voter
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_and_belongs_to_many :organizations
  has_many :identities, dependent: :destroy, foreign_key: 'voter_id'

  acts_as_voter
  acts_as_tagger

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
end
