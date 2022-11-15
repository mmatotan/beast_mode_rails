require 'swagger_helper'

describe 'Users sign in' do
  path '/users/sign_in' do
    post 'Sign in' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, format: :email },
              password: { type: :string, format: :password }
            },
            required: %w[email password]
          }
        }
      }

      response '201', 'Session created' do
        produces 'application/json'
        consumes 'application/json'
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 email: { type: :string, format: :email },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               }
        header 'Authorization', schema: { type: :string }, description: 'Bearer token used to authenticate the user.'

        let(:email) { Faker::Internet.email }
        let(:password) { Faker::Internet.password }
        let!(:user_create) { FactoryBot.create(:user, email:, password:, password_confirmation: password) }
        let(:user) { { user: { email:, password: } } }
        run_test!
      end

      response '401', 'Unauthorized' do
        produces 'application/json'
        consumes 'application/json'
        schema type: :object,
               properties: {
                 error: {
                   type: :string,
                   example: 'Invalid Email or password.',
                   description: 'Error message'
                 }
               }

        let(:user) do
          { user: { email: Faker::Internet.email, password: Faker::Internet.password } }
        end
        run_test!
      end
    end
  end
end
