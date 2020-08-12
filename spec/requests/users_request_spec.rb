require 'rails_helper'

describe 'User endpoint' do

  it 'can get a single user' do
    user = User.create!(username: 'testUser', 
                        email: 'test@test.com',
                        password: 'password',
                        password_confirmation: 'password')

    get "/users/#{user.id}"

    expect(response).to be_successful
    expect(response.status).to eq 200
    
    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to have_key :user

    expect(parsed_response[:user]).to have_key :data

    expect(parsed_response[:user][:data]).to have_key :id
    expect(parsed_response[:user][:data][:id]).to eq user.id.to_s

    expect(parsed_response[:user][:data]).to have_key :type
    expect(parsed_response[:user][:data][:type]).to eq user.class.to_s.downcase

    expect(parsed_response[:user][:data]).to have_key :attributes
    
    expect(parsed_response[:user][:data][:attributes]).to have_key :username
    expect(parsed_response[:user][:data][:attributes][:username]).to eq user.username
    expect(parsed_response[:user][:data][:attributes]).to have_key :email
    expect(parsed_response[:user][:data][:attributes][:email]).to eq user.email

    expect(parsed_response[:user][:data][:attributes]).to_not have_key :password
    expect(parsed_response[:user][:data][:attributes]).to_not have_key :password_digest
    expect(parsed_response[:user][:data][:attributes]).to_not have_key :password_confirmation
  end

end