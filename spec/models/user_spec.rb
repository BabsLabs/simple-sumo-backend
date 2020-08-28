require 'rails_helper'

describe User, type: :model do

  describe 'validations' do
    it { should validate_presence_of :username }
    it { should validate_uniqueness_of :username }
    it { should validate_length_of(:username).is_at_least(4) }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
    it { should validate_confirmation_of :password }
  end
  
  describe 'class methods' do
    it 'can verify users email' do
      user = create(:user)

      expect(user.email_confirmed).to eq(false)

      user.verify_user

      expect(user.email_confirmed).to eq(true)
    end

    it 'before_create action generates a users confirm_token' do
      user = build(:user)

      expect(user.confirm_token).to eq(nil)

      user.save

      expect(user.confirm_token.class).to eq(String)
      expect(user.confirm_token.class).to_not be_blank
    end

    it 'email_confirmed is set to false upon user creation' do
      user = create(:user)

      expect(user.email_confirmed).to eq(false)
    end
  end
end
