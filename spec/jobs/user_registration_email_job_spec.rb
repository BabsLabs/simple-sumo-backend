require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

describe UserRegistrationEmailJob, type: :job do
  it "should respond to #perform" do
    expect(UserRegistrationEmailJob.new).to respond_to(:perform)
  end

  describe "it increases jobs queue size" do

    before do
      Sidekiq::Extensions.enable_delay!
      Sidekiq::Worker.clear_all
    end

    it "should enqueue a Email and SMS job" do
      user = create(:user)
      email_info = { user: user}

      assert_equal 0, Sidekiq::Extensions::DelayedMailer.jobs.size

      UserNotifierMailer.delay.inform_registration(email_info)

      assert_equal 1, Sidekiq::Extensions::DelayedMailer.jobs.size
    end

  end
end