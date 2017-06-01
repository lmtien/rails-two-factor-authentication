ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "rails-tiduslmt.c9users.io",
  :user_name => "tien.2fa.notification@gmail.com",
  :password => "clqstcfmajhgbqmx",
  :authentication => "plain",
  :enable_starttls_auto => true
}