require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let!(:user) { create(:user) }
  let(:user_id) { user.id }

  before { host! "api.task-manager.test" }


  describe "GET /api/users/:id" do
    before do
      headers = { 'Accept' => 'application/vnd.taskmanager.v1' }
      get "/api/users/#{user_id}", params: {}, headers: headers
    end

    context "when the user exists" do
      it "returns the users" do
        user_response = JSON.parse(response.body)

        expect(user_response["id"]).to eq(user_id)
      end


    end

    
  end
end
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