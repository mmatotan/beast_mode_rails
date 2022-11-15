require 'swagger_helper'

describe 'Users sign out' do
  path '/users/sign_out' do
    post 'Sign out' do
      tags 'Users'
      security [jwt_auth: {}]
      parameter name: 'Authorization', in: :header, type: :string

      response '201', 'Session created' do
        # TODO: implement factory bot

        # let(:user) { FactoryBot.create(:user) }
        # let(:Authorization) { auth_header(user) }
        run_test!
      end
    end
  end
end
