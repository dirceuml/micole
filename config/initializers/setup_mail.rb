ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "micole.com",
  :user_name            => "sistema.micole.adm@gmail.com",
  :password             => "sistema2",
  :authentication       => "plain",
  :enable_starttls_auto => true
}