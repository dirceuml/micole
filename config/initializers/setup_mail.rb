ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "micole.com",
  :user_name            => "micole.sistema@gmail.com",
  :password             => "micole14",
  :authentication       => "plain",
  :enable_starttls_auto => true
}