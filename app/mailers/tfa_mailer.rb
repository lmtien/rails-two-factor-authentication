class TfaMailer < ApplicationMailer
  def tfa_confirmation(email)
    mail to: "tiduslmt@gmail.com", subject: "Testing 2FA", content_type: "text/html"
  end
end
