require 'swagger_helper'

describe 'Users registration' do
  path '/users' do
    post 'Create a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, format: :email },
              password: { type: :string, format: :password },
              password_confirmation: { type: :string, format: :password }
            },
            required: %w[email password password_confirmation]
          }
        }
      }

      response '201', 'Created' do
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
        let(:user) do
          { user: { email: 'marko.matotan4@gmail.com', password: 'password123', password_confirmation: 'password123' } }
        end
        run_test!
      end

      response '422', 'Unprocessable Entity' do
        produces 'application/json'
        consumes 'application/json'
        schema type: :object,
               properties: {
                 errors: {
                   type: :object,
                   properties: {
                     invalid_field: {
                       type: :array,
                       items: {
                         type: :string,
                         example: "can't be blank",
                         description: 'Error message'
                       }
                     }
                   }
                 }
               }

        let(:user) do
          { user: { email: 'marko.matotan4@gmail.com', password: 'password123' } }
        end
        run_test!
      end

    end
  end
end
