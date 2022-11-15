require 'swagger_helper'

describe 'Users sign out' do
  path '/users/sign_out' do
    delete 'Sign out' do
      tags 'Users'
      security [jwt_auth: []]
      parameter name: 'Authorization', in: :header, type: :string

      response '204', 'Session destroyed' do
        let(:user) { FactoryBot.create(:user) }
        let(:Authorization) { Devise::JWT::TestHelpers.auth_headers({}, user)['Authorization'] }

        run_test!
      end
    end
  end
end
