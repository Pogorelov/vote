require 'rails_helper'

RSpec.describe Identity, :type => :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider) }
  end

  describe '.find_for_google_oauth' do
    let(:auth) do
      {
        :provider => "google_oauth2",
        :uid => "123456789",
        :info => {
          :name => "John Doe",
          :email => "john@company_name.com",
          :first_name => "John",
          :last_name => "Doe",
          :image => "https://lh3.googleusercontent.com/url/photo.jpg"
        },
        :credentials => {
          :token => "token",
          :refresh_token => "another_token",
          :expires_at => 1354920555,
          :expires => true
        },
        :extra => {
          :raw_info => {
            :sub => "123456789",
            :email => "user@domain.example.com",
            :email_verified => true,
            :name => "John Doe",
            :given_name => "John",
            :family_name => "Doe",
            :profile => "https://plus.google.com/123456789",
            :picture => "https://lh3.googleusercontent.com/url/photo.jpg",
            :gender => "male",
            :birthday => "0000-06-25",
            :locale => "en",
            :hd => "company_name.com"
          }
        }
      }.with_indifferent_access
    end

    let(:find_for_google_oauth) { Identity.find_for_google_oauth(auth) }

    context 'identity does not exist' do
      context 'user does not exist' do
        it { expect{ find_for_google_oauth }.to change{ User.count }.by(1) }
        it { expect{ find_for_google_oauth }.to change{ Identity.count }.by(1) }
      end

      context 'user exists' do
        let!(:user) { create(:user, email: auth['info']['email']) }

        it { expect{ find_for_google_oauth }.not_to change{ User.count } }
        it { expect{ find_for_google_oauth }.to change{ Identity.count }.by(1) }
        it { expect(find_for_google_oauth).to eql user }
      end
    end

    context 'identity exists' do
      let!(:user) { create(:user, email: auth['info']['email']) }
      let!(:identity) { create(:identity, provider: auth['provider'], uid: auth['uid'], user: user) }

      it { expect{ find_for_google_oauth }.not_to change{ User.count } }
      it { expect{ find_for_google_oauth }.not_to change{ Identity.count } }

      it { expect(find_for_google_oauth).to eql user }
    end
  end
end
