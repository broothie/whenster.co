ActionMailer::Base.smtp_settings = {
  user_name: 'apikey',
  password: Config.sendgrid_api_key,
  domain: 'whenster.co',
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
