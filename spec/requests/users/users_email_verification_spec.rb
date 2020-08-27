require 'rails_helper'

describe 'User email verification endpoint' do
    it 'a User can verify their email' do
        user = create(:user)

        get "/users/#{user.confirm_token}/confirm_email"

        user.reload

        expect(user.confirm_token).to eq(nil)
        expect(user.email_confirmed).to eq(true)

        expect(response.status).to eq(302)
        expect(response).to redirect_to("http://babslabs-simple-sumo.herokuapp.com/login")

        expected_response_body = "<html><body>You are being <a href=\"http://babslabs-simple-sumo.herokuapp.com/login\">redirected</a>.</body></html>"
        expect(response.body).to eq(expected_response_body)
    end
end