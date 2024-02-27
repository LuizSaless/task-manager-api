require 'rails_helper'

RSpec.describe User, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
let(:user) { build(:user) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to allow_value("luiznew7@hotmail.com").for(:email) } 
    it { is_expected.to validate_uniqueness_of(:auth_token)}

    describe '#info' do
      it 'returns email, created_at and a Token' do
        user.save!
        allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')

        expect(user.info).to eq("#{user.email} - #{user.created_at} - Token: abc123xyzTOKEN")
      end
    end

    describe '#generation_authenticate_token!' do

      it 'generate a unique token' do        
        allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')
        user.generate_authentication_token!

        expect(user.auth_token).to eq('abc123xyzTOKEN')
      end

      it 'generate another auth_token when the current auth token already has been taken' do
        allow(Devise).to receive(:friendly_token).and_return('TOKENabc123xyz','TOKENabc123xyz','abcXYZ123 456789')
        existing_user = create(:user)
        user.generate_authentication_token!
        
        expect(user.auth_token).not_to eq(existing_user.auth_token)
      end

    end


  
      # it { expect(user).to respond_to(:email) }

      # it { expect(user).to validate_presence_of(:name) }


    # context 'when name is blank' do
    #   before { user.name = " " } 

    #   it { expect(user).not_to be_valid }
    # end

    # context 'when name is nil' do
    #   before { user.name = nil } 

    #   it { expect(user).not_to be_valid }
    # end

  # before { @user = FactoryBot.build(:user) }

  # it { expect(@user).to respond_to(:email) }
  # it { expect(@user).to respond_to(:name) }
  # it { expect(@user).to respond_to(:password) }
  # it { expect(@user).to respond_to(:password_confirmation) }
  # it { expect(@user).to be_valid }
end
