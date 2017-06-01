class TfaMailer < ApplicationMailer
  def tfa_confirmation(email, code)
    @code = code
    mail to: email, subject: "Your 2FA Code", content_type: "text/html"
  end
end
