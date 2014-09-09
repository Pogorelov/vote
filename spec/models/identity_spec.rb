require 'rails_helper'

RSpec.describe Identity, :type => :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider) }
  end
end
