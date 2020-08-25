require "rails_helper"

describe UserNotifierMailer, type: :mailer do
  it 'sends a mailer' do
    text_email_fixture = file_fixture("inform_registration_fixture.text.erb").read
    html_email_fixture = file_fixture("inform_registration_fixture.html.erb").read

    user = create(:user, username: 'TestUsername')
    email = UserNotifierMailer.with(user: user).inform_registration

    email.deliver_now

    
    expect(email.from).to eq(['info@babslabs.com'])
    expect(email.to).to eq([user.email])
    expect(email.subject).to eq("You have registered with Simple Sumo #{user.username}!")
    
    expect(email.parts.length).to eq(2)
    
    expect(email.parts[0].content_type.to_s).to eq('text/plain; charset=UTF-8')
    expect(email.parts[0].body).to eq(text_email_fixture)

    expect(email.parts[1].content_type.to_s).to eq('text/html; charset=UTF-8')
    expect(email.parts[1].body).to eq(html_email_fixture)
  end
end
