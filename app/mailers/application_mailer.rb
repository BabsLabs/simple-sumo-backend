class ApplicationMailer < ActionMailer::Base
  default from: 'info@babslabs.com'
  default "Message-ID"=>"#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@babslabs.com"
  layout 'mailer'
end
