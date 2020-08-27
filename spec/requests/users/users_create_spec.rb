require 'rails_helper'

describe 'POST /users endpoint' do
  let(:user_params) do
    {user: { username: 'GoodTestUsername', email: 'GoodTestUsername@test.com', password: 'test_password', password_confirmation: 'test_password',  }}
  end

  let(:no_username_params) do
    {user: { username: '', email: 'NoUsername@test.com', password: 'test_password', password_confirmation: 'test_password' }}
  end

  let(:no_email_params) do
    {user: { username: 'NoEmailUsername', email: '', password: 'test_password', password_confirmation: 'test_password' }}
  end

  let(:no_password_params) do
    {user: { username: 'NoPasswordUsername', email: 'NoPasswordUsername@test.com', password: '', password_confirmation: 'test_password' }}
  end

  let(:bad_password_params) do
    {user: { username: 'NotMatchingPasswordUsername', email: 'NotMatchingPasswordUsername@test.com', password: 'fdafadsfadf', password_confirmation: 'test_password' }}
  end

  let(:bad_email_params) do
    {user: { username: 'BadEmailUsername', email: 'BadEmail', password: 'test_password', password_confirmation: 'test_password' }}
  end

  it 'can respond to a POST request with valid params' do
    user_1 = create(:user)

    expect(User.count).to eq 1

    post '/users', params: user_params

    expect(response).to have_http_status 201

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to have_key :user
    expect(parsed_response[:user]).to have_key :data
    expect(parsed_response[:user][:data]).to have_key :id
    expect(parsed_response[:user][:data][:id]).to eq User.last.id.to_s
    expect(parsed_response[:user][:data]).to have_key :type
    expect(parsed_response[:user][:data][:type]).to eq 'user'
    expect(parsed_response[:user][:data]).to have_key :attributes
    expect(parsed_response[:user][:data][:attributes]).to have_key :username
    expect(parsed_response[:user][:data][:attributes][:username]).to eq User.last.username
    expect(parsed_response[:user][:data][:attributes]).to have_key :email
    expect(parsed_response[:user][:data][:attributes][:email]).to eq User.last.email
  end

  it 'returns an error message if no username is given' do
    post '/users', params: no_username_params

    expect(response).to be_successful
    expect(response).to have_http_status 200

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to have_key :errors
    expect(parsed_response[:errors]).to be_an Array
    expect(parsed_response[:errors][0]).to eq "Username can't be blank"
  end 

  it 'returns an error message if no email is given' do
    post '/users', params: no_email_params

    expect(response).to be_successful
    expect(response).to have_http_status 200

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to have_key :errors
    expect(parsed_response[:errors]).to be_an Array
    expect(parsed_response[:errors][0]).to eq "Email can't be blank"
  end 

  it 'returns an error message if no password is given' do
    post '/users', params: no_password_params

    expect(response).to be_successful
    expect(response).to have_http_status 200

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to have_key :errors
    expect(parsed_response[:errors]).to be_an Array
    expect(parsed_response[:errors][0]).to eq "Password can't be blank"
  end 

  it 'returns an error message if a passwords do not match or confirmation is missing' do
    post '/users', params: bad_password_params

    expect(response).to be_successful
    expect(response).to have_http_status 200

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to have_key :errors
    expect(parsed_response[:errors]).to be_an Array
    expect(parsed_response[:errors][0]).to eq "Password confirmation doesn't match Password"
  end 

  it 'returns an error message if a bad email is given' do
    post '/users', params: bad_email_params

    expect(response).to be_successful
    expect(response).to have_http_status 200

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to have_key :errors
    expect(parsed_response[:errors]).to be_an Array
    expect(parsed_response[:errors][0]).to eq "Email is invalid"
  end 
end