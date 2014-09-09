require 'rails_helper'

describe User do
  describe '#email' do
    subject(:user) { create :user, email: 'user@example.com' }

    it { is_expected.to respond_to :email }
    it { expect(user.email).to eql 'user@example.com' }
  end

  describe 'associations' do
    it { is_expected.to have_many(:identities).dependent(:destroy) }
  end
end
