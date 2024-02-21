require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let!(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:headers) do
    {'Accept'=>'application/vnd.taskmanager.v1', 
    'Content-Type'=> Mime[:json].to_s}
  end

  before {host! "api.taskmanager.test:3000"}
  describe 'GET users/:id' do
    before do
      get "/users/#{user_id}", :params => {}, :headers=> headers
    end

    context 'when the user exists' do
      it 'returns the user' do
        user_response = JSON.parse(response.body)
        expect(user['id']).to eq(user_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the user does not exists" do
      let(:user_id) { 10000 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
    
  end

  describe 'POST /users' do
    before do
      post '/users', params:{user: user_params}.to_json, headers: headers
    end

    context 'when the request params are valid' do

      let(:user_params){ attributes_for(:user)}

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns the json data for the created user' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eq(user_params[:email])
      end

    end

    context 'when the request params are invalid' do
      let(:user_params) { { email: 'New_email@' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'return JSON data with errors' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end
    end

  end

  describe 'PUT /users/:id' do
    before do
      put "/users/#{user_id}", params:{user: user_params}.to_json, headers: headers
    end

    context 'when the request params are valid' do
      let(:user_params) { { email: 'new_email@taskmanager.com' } }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'return JSON data with update information' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eq(user_params[:email])
      end
    end

    context 'when the request params are invalid' do
      let(:user_params) { { email: 'New_email@' } }   

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'return JSON data with errors' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end

    end

  end

  describe 'DELETE /users/:id' do
    before do
      delete "/users/#{user_id}", params:{}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'removes the user from database' do
      expect(User.find_by(id: user.id)).to be_nil
    end
  end

end

# require 'rails_helper'

# RSpec.describe "Api::V1::Users", type: :request do



#     it "user is valid" do
#       user = FactoryBot.create(:user)
#       expect(user).to be_valid
#     end

# end

# require 'rails_helper'

# RSpec.describe "Api::V1::Users", type: :request do

#   describe User do
#     before { @user = FactoryBot.build(:user) }

#     # subject { @user }

#     # it { should respond_to(:email) }
#     # it { should respond_to(:password) }
#     # it { should respond_to(:password_confirmation) }

#     # it { should be_valid }
#   end
# end
# Specs in this file have access to a helper object that includes
# the Api::V1::UsersHelper. For example:
#
# describe Api::V1::UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
# RSpec.describe Api::V1::UsersHelper, type: :helper do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
# describe "GET /index" do
#   pending "add some examples (or delete) #{__FILE__}"
# end
