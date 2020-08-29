require 'rails_helper'

describe 'User email verification endpoint' do
  it 'a User can verify their email' do
    user = create(:user)

    get "/users/#{user.confirm_token}/confirm_email"

    user.reload

    expect(user.email_confirmed).to eq(true)

    expect(response.status).to eq(302)
    expect(response).to redirect_to("https://babslabs-simple-sumo.herokuapp.com/login?verified=successful")
    
    expected_response_body = "<html><body>You are being <a href=\"https://babslabs-simple-sumo.herokuapp.com/login?verified=successful\">redirected</a>.</body></html>"
    expect(response.body).to eq(expected_response_body)
end

it 'a User cannot verify email twice' do
    user = create(:user)
    
    get "/users/#{user.confirm_token}/confirm_email"
    
    user.reload
    
    get "/users/#{user.confirm_token}/confirm_email"
    
    expect(response.status).to eq(302)
    expect(response).to redirect_to("https://babslabs-simple-sumo.herokuapp.com/login?verified=already_verified")

    expected_response_body = "<html><body>You are being <a href=\"https://babslabs-simple-sumo.herokuapp.com/login?verified=already_verified\">redirected</a>.</body></html>"
    expect(response.body).to eq(expected_response_body)
  end
end