require 'rails_helper'

RSpec.describe "User Registration", type: :request do
  describe "POST /users" do
    let(:valid_params) do
      {
        user: {
          username: 'testuser',
          email: 'test@example.com',
          password: 'password'
        }
      }
    end

    describe "when the request is valid" do
      before { post '/users', params: valid_params }

      it 'creates a user' do
        expect(response).to have_http_status(302)  
      end

      it 'redirects to the verification sent path' do
        expect(response).to redirect_to(verification_sent_path)
      end
    end

    describe "when the request is invalid" do
      let!(:existing_user) { User.create(username: 'existinguser', email: 'test@example.com', password: 'password') }

      let(:invalid_params) do
        {
          user: {
            username: 'testuser',
            email: 'test@example.com', 
            password: 'password'
          }
        }
      end

      before { post '/users', params: invalid_params }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)  
      end
    end
  end
end